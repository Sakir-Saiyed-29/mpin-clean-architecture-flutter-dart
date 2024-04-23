import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_bloc.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_event.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_state.dart';
import 'package:mpin_demo/features/set_mpin/presentation/view/homepage_screen.dart';
import 'package:mpin_demo/main.dart';

class MockLoginBloc extends MockBloc<MpinEvent, MpinState>
    implements MpinBloc {}

void main() {
  testWidgets('Render Home page', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyHomePage), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
