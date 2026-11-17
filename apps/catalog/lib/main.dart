import 'package:cs_catalog/src/catalog_app.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:cs_catalog/src/catalog_app.dart';

void main() {
  runApp(const App());
}

/// The catalog app with external links opened by the platform.
class App extends StatelessWidget {
  /// Creates the app.
  const App({super.key});

  @override
  Widget build(BuildContext context) => CatalogApp(
    onOpenUrl: (url) => launchUrl(url, webOnlyWindowName: '_blank'),
  );
}
