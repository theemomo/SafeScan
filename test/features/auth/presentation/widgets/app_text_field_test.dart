import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_scan/features/auth/presentation/widgets/app_text_field.dart';

void main() {
  // A helper function to wrap the widget in a MaterialApp and Scaffold
  Widget makeTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        home: Scaffold(body: Form(child: child)),
      ),
    );
  }

  group('AppTextField Widget Tests', () {
    late TextEditingController controller;
    late FocusNode focusNode;

    setUp(() {
      controller = TextEditingController();
      focusNode = FocusNode();
    });

    tearDown(() {
      controller.dispose();
      focusNode.dispose();
    });

    testWidgets('renders correctly with the given label', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        makeTestableWidget(
          AppTextField(
            fieldController: controller,
            fieldFocusNode: focusNode,
            onFieldSubmitted: (_) {},
            label: 'Test Label',
            validator: null,
          ),
        ),
      );

      // Assert
      expect(find.byType(AppTextField), findsOneWidget);
      expect(find.text('Test Label'), findsOneWidget);
    });

    testWidgets('typing text updates the TextEditingController', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        makeTestableWidget(
          AppTextField(
            fieldController: controller,
            fieldFocusNode: focusNode,
            onFieldSubmitted: (_) {},
            label: 'Test Label',
            validator: null,
          ),
        ),
      );

      // Act
      // Simulate user typing text into the TextFormField
      await tester.enterText(find.byType(TextFormField), 'Hello, World!');
      // Rebuild the widget after the state has changed
      await tester.pump();

      // Assert
      expect(controller.text, 'Hello, World!');
    });

    group('Standard Text Field (isPassword: false)', () {
      testWidgets('text is visible and no visibility icon is present', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          makeTestableWidget(
            AppTextField(
              fieldController: controller,
              fieldFocusNode: focusNode,
              onFieldSubmitted: (_) {},
              label: 'Username',
              validator: null,
              isPassword: false,
            ),
          ),
        );

        // Act
        await tester.enterText(find.byType(TextFormField), 'my_username');
        await tester.pump();

        // Assert
        final editableText = tester.widget<EditableText>(
          find.byType(EditableText),
        );
        expect(editableText.obscureText, isFalse);
        expect(find.byIcon(Icons.visibility), findsNothing);
        expect(find.byIcon(Icons.visibility_off), findsNothing);
      });
    });

    group('Password Field (isPassword: true)', () {
      testWidgets('text is initially obscured and visibility icon is present', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          makeTestableWidget(
            AppTextField(
              fieldController: controller,
              fieldFocusNode: focusNode,
              onFieldSubmitted: (_) {},
              label: 'Password',
              validator: null,
              isPassword: true,
            ),
          ),
        );

        // Act
        await tester.enterText(find.byType(TextFormField), 's3cr3t');
        await tester.pump();

        // Assert
        final editableText = tester.widget<EditableText>(
          find.byType(EditableText),
        );
        expect(editableText.obscureText, isTrue); // Text should be obscured
        expect(
          find.byIcon(Icons.visibility_off),
          findsOneWidget,
        ); // Icon should be present
        expect(find.byIcon(Icons.visibility), findsNothing);
      });

      testWidgets('tapping visibility icon toggles text obscurity', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          makeTestableWidget(
            AppTextField(
              fieldController: controller,
              fieldFocusNode: focusNode,
              onFieldSubmitted: (_) {},
              label: 'Password',
              validator: null,
              isPassword: true,
            ),
          ),
        );

        // Assert initial state (obscured)
        var editableText = tester.widget<EditableText>(
          find.byType(EditableText),
        );
        expect(editableText.obscureText, isTrue);
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);

        // Act: Tap the icon to show the password
        await tester.tap(find.byIcon(Icons.visibility_off));
        await tester.pump();

        // Assert: Text should now be visible
        editableText = tester.widget<EditableText>(find.byType(EditableText));
        expect(editableText.obscureText, isFalse);
        expect(find.byIcon(Icons.visibility), findsOneWidget);

        // Act: Tap the icon again to hide the password
        await tester.tap(find.byIcon(Icons.visibility));
        await tester.pump();

        // Assert: Text should be obscured again
        editableText = tester.widget<EditableText>(find.byType(EditableText));
        expect(editableText.obscureText, isTrue);
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      });
    });

    testWidgets('displays validation error when validator returns an error', (
      WidgetTester tester,
    ) async {
      // Arrange
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (_, __) => MaterialApp(
            home: Scaffold(
              body: Form(
                key: formKey,
                child: AppTextField(
                  fieldController: controller,
                  fieldFocusNode: focusNode,
                  onFieldSubmitted: (_) {},
                  label: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Act: Try to validate the empty form
      formKey.currentState!.validate();
      await tester.pump();

      // Assert
      expect(find.text('Email is required'), findsOneWidget);
    });
  });
}
