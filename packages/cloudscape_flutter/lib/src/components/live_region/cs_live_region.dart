import 'dart:async';
import 'dart:ui' show FlutterView;

import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

/// Upstream `LiveRegionProps.TagName`. Flutter has no inline/block element
/// distinction, so this does not change layout; kept for prop parity.
enum CsLiveRegionTagName {
  /// `span`.
  span,

  /// `div` (default).
  div,
}

/// Announces messages through the platform screen reader with upstream's
/// throttling and deduplication (port of `LiveRegionController`).
class CsLiveRegionController {
  /// Creates a controller. [delay] is in seconds (default 1, like upstream).
  CsLiveRegionController({
    required this.view,
    required this.textDirection,
    this.assertive = false,
    double? delay,
  }) : delay = delay ?? defaultDelay;

  /// Default throttle delay in seconds (set to 0 in tests to announce
  /// synchronously, like upstream).
  static double defaultDelay = 1;

  /// Test hook: receives every announcement instead of the platform.
  @visibleForTesting
  static void Function(String message, Assertiveness assertiveness)?
  debugOnAnnounce;

  /// The view to announce in.
  final FlutterView view;

  /// Reading direction of announcements.
  TextDirection textDirection;

  /// `assertive` vs `polite`.
  final bool assertive;

  /// Throttle delay in seconds.
  final double delay;

  bool _contentChangedSinceLastAnnouncement = false;
  bool _addedTerminalPeriod = false;
  String _nextAnnouncement = '';
  String? _lastAnnouncement;
  Timer? _timer;

  /// The text currently announced (for tests and debugging).
  String? get currentText => _currentText;
  String? _currentText;

  /// Stops pending announcements.
  void destroy() {
    _timer?.cancel();
    _timer = null;
  }

  /// Queues [message]; repeats are dropped unless content changed in
  /// between or [forceReannounce] is set.
  void announce(String? message, {bool forceReannounce = false}) {
    final trimmed = message?.trim() ?? '';
    if (trimmed != _lastAnnouncement) {
      _contentChangedSinceLastAnnouncement = true;
    }
    _nextAnnouncement = trimmed;
    if (message == null || message.isEmpty) return;
    if (delay == 0 || forceReannounce) {
      _update(forceReannounce);
      return;
    }
    _timer ??= Timer(
      Duration(microseconds: (delay * 1e6).round()),
      () => _update(false),
    );
  }

  void _update(bool forceReannounce) {
    String? text;
    if (_nextAnnouncement != _lastAnnouncement) {
      text = _nextAnnouncement;
      _addedTerminalPeriod = false;
    } else if (forceReannounce || _contentChangedSinceLastAnnouncement) {
      // Toggling a terminal period forces screen readers to re-read.
      text = _nextAnnouncement + (_addedTerminalPeriod ? '' : '.');
      _addedTerminalPeriod = !_addedTerminalPeriod;
    }
    _lastAnnouncement = _nextAnnouncement;
    _contentChangedSinceLastAnnouncement = false;
    _timer = null;
    if (text == null) return;
    _currentText = text;
    final assertiveness = assertive
        ? Assertiveness.assertive
        : Assertiveness.polite;
    final hook = debugOnAnnounce;
    if (hook != null) {
      hook(text, assertiveness);
    } else {
      unawaited(
        SemanticsService.sendAnnouncement(
          view,
          text,
          textDirection,
          assertiveness: assertiveness,
        ),
      );
    }
  }
}

/// Text content of an element subtree, like DOM `textContent` with
/// whitespace collapsed (upstream `extractTextContent`).
String csExtractTextContent(Element root) {
  final parts = <String>[];
  void visit(Element e) {
    final w = e.widget;
    if (w is RichText) {
      parts.add(w.text.toPlainText(includeSemanticsLabels: false));
      return;
    }
    e.visitChildren(visit);
  }

  root.visitChildren(visit);
  return parts.join(' ').replaceAll(RegExp(r'\s+'), ' ').trim();
}

/// Announces its text content to screen readers when it changes (upstream
/// `LiveRegion`). Use [hidden] to announce without showing the content.
class CsLiveRegion extends StatefulWidget {
  /// Creates a live region.
  const CsLiveRegion({
    super.key,
    this.assertive = false,
    this.hidden = false,
    this.tagName = CsLiveRegionTagName.div,
    this.delay,
    this.sources,
    this.preventInitialAnnouncement = false,
    this.child,
  });

  /// Interrupt the screen reader instead of waiting.
  final bool assertive;

  /// Hide the content visually and from interaction; it is still announced.
  final bool hidden;

  /// Upstream tag name (no layout effect in Flutter).
  final CsLiveRegionTagName tagName;

  /// Throttle delay in seconds (internal upstream prop).
  final double? delay;

  /// Announce these instead of the content: strings, or [GlobalKey]s whose
  /// subtree text is read (internal upstream prop).
  final List<Object?>? sources;

  /// Do not announce the content present on first render.
  final bool preventInitialAnnouncement;

  /// The content.
  final Widget? child;

  @override
  State<CsLiveRegion> createState() => CsLiveRegionState();
}

/// State of [CsLiveRegion]; call [reannounce] (upstream ref API).
class CsLiveRegionState extends State<CsLiveRegion> {
  CsLiveRegionController? _controller;
  final GlobalKey _contentKey = GlobalKey();
  String? _initial;
  bool _initialCaptured = false;

  /// The live region's controller (for tests).
  @visibleForTesting
  CsLiveRegionController? get controller => _controller;

  void _createController() {
    _controller?.destroy();
    _controller = CsLiveRegionController(
      view: View.of(context),
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      assertive: widget.assertive,
      delay: widget.delay,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller == null) {
      _createController();
    } else {
      _controller!.textDirection =
          Directionality.maybeOf(context) ?? TextDirection.ltr;
    }
  }

  @override
  void didUpdateWidget(CsLiveRegion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assertive != widget.assertive ||
        oldWidget.delay != widget.delay) {
      _createController();
    }
  }

  @override
  void dispose() {
    _controller?.destroy();
    super.dispose();
  }

  String _content() {
    final sources = widget.sources;
    if (sources != null) {
      return sources
          .map((s) {
            if (s is String) return s;
            if (s is GlobalKey && s.currentContext != null) {
              return csExtractTextContent(s.currentContext! as Element);
            }
            return null;
          })
          .whereType<String>()
          .where((s) => s.isNotEmpty)
          .join(' ');
    }
    final ctx = _contentKey.currentContext;
    return ctx == null ? '' : csExtractTextContent(ctx as Element);
  }

  void _afterBuild() {
    if (!mounted) return;
    final message = _content();
    if (!_initialCaptured) {
      _initialCaptured = true;
      _initial = message;
    }
    if (widget.preventInitialAnnouncement && _initial == message) return;
    _controller?.announce(message);
  }

  /// Announces the current content again, even if unchanged.
  void reannounce() => _controller?.announce(_content(), forceReannounce: true);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterBuild());
    final content = KeyedSubtree(
      key: _contentKey,
      child: widget.child ?? const SizedBox.shrink(),
    );
    if (!widget.hidden) return content;
    // `hidden` + `inert`: not shown, not interactive, not in the semantics
    // tree, but still mounted so its text can be announced.
    return Offstage(
      child: ExcludeSemantics(
        child: ExcludeFocus(child: IgnorePointer(child: content)),
      ),
    );
  }
}
