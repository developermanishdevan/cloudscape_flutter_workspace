import 'package:cs_catalog/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app shell renders without Material', (tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Cloudscape Catalog'), findsOneWidget);
  });
}
