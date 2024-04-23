import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';
import '../helper/helper.dart';

void main() {
  testWidgets('Pins are displayed properly', (WidgetTester tester) async {
    const length = 4;
    await tester.pumpApp(const Pinput(length: length));
    expect(find.byType(Flexible), findsNWidgets(length));
    expect(find.byType(Text), findsNWidgets(length));
  });

  testWidgets('enter pin value', (WidgetTester tester) async {
    String? fieldValue;
    int called = 0;
    final controller = TextEditingController();
    final focusNode = FocusNode();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Pinput(
            controller: controller,
            onChanged: (value) {
              fieldValue = value;
              called++;
            },
          ),
        ),
      ),
    );

    focusNode.requestFocus();
    await tester.pump();

    expect(fieldValue, isNull);
    expect(called, 0);

    await tester.enterText(find.byType(Pinput), '1111');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(fieldValue, equals('1111'));
    expect(called, 1);

    await tester.enterText(find.byType(Pinput), '2222');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(fieldValue, equals('2222'));
    expect(called, 2);

    await tester.enterText(find.byType(Pinput), '3333');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(fieldValue, equals('3333'));
    expect(called, 3);
  });

  testWidgets('onCompleted callback is called', (WidgetTester tester) async {
    final TextEditingController controller = TextEditingController();
    String? fieldValue;
    int called = 0;

    await tester.pumpApp(
      Pinput(
        controller: controller,
        onCompleted: (value) {
          fieldValue = value;
          called++;
        },
      ),
    );

    expect(fieldValue, isNull);
    expect(called, 0);

    controller.setText('1234');
    expect(fieldValue, equals('1234'));
    expect(called, 1);

    fieldValue = null;
    await tester.enterText(find.byType(EditableText), '123');
    expect(fieldValue, isNull);
    expect(called, 1);
  });
}
