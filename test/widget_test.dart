import 'package:flutter_test/flutter_test.dart';
import 'package:sentinel_waf/main.dart';

void main() {
  testWidgets('Sentinel AI WAF Console smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SentinelWafApp());
    await tester.pumpAndSettle();

    expect(find.text('SENTINEL AI'), findsOneWidget);
    expect(find.text('Overview'), findsWidgets);
  });
}
