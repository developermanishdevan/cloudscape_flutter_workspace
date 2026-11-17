import 'package:cloudscape_flutter/cloudscape_flutter.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const App());
}

/// Placeholder shell until the first components land.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CsApp(
      title: 'Cloudscape Demos',
      home: Builder(
        builder: (context) => Center(
          child: Text(
            'Cloudscape Demos',
            style: CsTypography(context.csTokens).headingXl,
          ),
        ),
      ),
    );
  }
}
