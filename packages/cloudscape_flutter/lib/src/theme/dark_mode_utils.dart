import 'package:cloudscape_flutter/src/theme/cs_theme.dart';
import 'package:flutter/widgets.dart';

/// Shows [child] only in dark mode. Port of global-styles
/// `.awsui-util-show-in-dark-mode`.
class CsShowInDarkMode extends StatelessWidget {
  /// Creates the utility.
  const CsShowInDarkMode({super.key, required this.child});

  /// The content.
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      CsTheme.of(context).isDark ? child : const SizedBox.shrink();
}

/// Hides [child] in dark mode. Port of global-styles
/// `.awsui-util-hide-in-dark-mode`.
class CsHideInDarkMode extends StatelessWidget {
  /// Creates the utility.
  const CsHideInDarkMode({super.key, required this.child});

  /// The content.
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      CsTheme.of(context).isDark ? const SizedBox.shrink() : child;
}
