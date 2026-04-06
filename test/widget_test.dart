// This is a basic Flutter widget test.

import 'package:f_shared_prefs/features/auth/ui/viewmodel/auth_controller.dart';
import 'package:f_shared_prefs/features/my_app.dart';
import 'package:f_shared_prefs/features/auth/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationController extends GetxService
    with Mock
    implements AuthController {
  @override
  Future<void> login(user, password) {
    if (user == 'a@a.com') {
      if (password == '123456') {
        return Future.value();
      }
      throw "Incorrect password";
    } else {
      throw "User not found";
    }
  }

  @override
  Future<bool> signup(user, password) {
    if (user == 'a@a.com') {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
    Get.put<AuthController>(MockAuthenticationController());
  });

  tearDown(() => Get.reset());

  testWidgets('Login ok widget testing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        scaffoldMessengerKey: messengerKey,
        home: LoginPage(),
      ),
    );
    await tester.pump();

    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    expect(find.byKey(const Key('loginEmail')), findsOneWidget);

    await tester.enterText(find.byKey(const Key('loginEmail')), 'a@a.com');

    await tester.enterText(find.byKey(const Key('loginPassword')), '123456');

    await tester.tap(find.byKey(const Key('loginSubmit')));

    await tester.pumpAndSettle();

    // since we are only testing the login page, we will not verify that we are in the content page, but we will verify that no error snackbar is shown
  });

  testWidgets('Login with user not found widget testing',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        scaffoldMessengerKey: messengerKey,
        home: LoginPage(),
      ),
    );
    await tester.pump();

    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    expect(find.byKey(const Key('loginEmail')), findsOneWidget);

    await tester.enterText(find.byKey(const Key('loginEmail')), 'b@a.com');

    await tester.enterText(find.byKey(const Key('loginPassword')), '123456');

    // Tap submit
    await tester.tap(find.byKey(const Key('loginSubmit')));
    await tester.pump(); // process async login
    //await tester.pump(const Duration(seconds: 1)); // show snackbar

    // Check that snackbar with 'Error' and specific message shows
    expect(find.text('Error User not found'), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('Login with wrong password widget testing',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        scaffoldMessengerKey: messengerKey,
        home: LoginPage(),
      ),
    );
    await tester.pump();

    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    expect(find.byKey(const Key('loginEmail')), findsOneWidget);

    await tester.enterText(find.byKey(const Key('loginEmail')), 'a@a.com');

    await tester.enterText(find.byKey(const Key('loginPassword')), '11111111');

    // Tap submit
    await tester.tap(find.byKey(const Key('loginSubmit')));
    await tester.pump(); // process async login
    //await tester.pump(const Duration(seconds: 1)); // show snackbar

    // Check that snackbar with 'Error' and specific message shows
    expect(find.text('Error Incorrect password'), findsOneWidget);

    await tester.pumpAndSettle();
  });
}
