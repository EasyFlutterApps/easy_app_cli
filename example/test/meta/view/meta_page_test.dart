import 'package:flutter_test/flutter_test.dart';
import '../../../lib/modules/meta/meta.dart';
import '../../../lib/app/app.dart';

void main() {
  group('MetaPage', () {
    testWidgets('renders MetaPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MetaPage), findsOneWidget);
    });
  });
}