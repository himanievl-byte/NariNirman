import 'package:flutter_test/flutter_test.dart';

import 'package:narinirman/main.dart';
import 'package:narinirman/services.dart';

void main() {
  testWidgets('app starts on the onboarding screen', (tester) async {
    await tester.pumpWidget(const NariNirmanApp());
    expect(find.textContaining('NariNirman'), findsOneWidget);
  });

  test('parseListing understands a spoken sentence', () {
    final d = parseListing(
      'I make handmade crochet bags. Each bag costs ₹350, and I can make five bags per week.',
    );
    expect(d.name, 'handmade crochet bags');
    expect(d.price, 350);
    expect(d.qty, 5);
  });

  test('suggestedPrice adds costs and profit', () {
    expect(suggestedPrice(materials: 100, packaging: 20, labour: 80, profit: 100), 300);
  });
}
