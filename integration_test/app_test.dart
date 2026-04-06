import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:f_shared_prefs/core/i_local_preferences.dart';
import 'package:f_shared_prefs/core/local_preferences_secured.dart';
import 'package:f_shared_prefs/core/local_preferences_shared.dart';
import 'package:f_shared_prefs/features/auth/data/data_source/i_local_auth_source.dart';
import 'package:f_shared_prefs/features/auth/data/data_source/simple_local_auth_source.dart';
import 'package:f_shared_prefs/features/auth/data/repositories/auth_repo.dart';
import 'package:f_shared_prefs/features/auth/domain/repositories/i_auth_repo.dart';
import 'package:f_shared_prefs/features/auth/domain/use_case/auth_use_case.dart';
import 'package:f_shared_prefs/features/auth/ui/viewmodel/auth_controller.dart';
import 'package:f_shared_prefs/features/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

Future<Widget> createHomeScreen() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.deleteAll();
  if (!kIsWeb) {
    Get.put<ILocalPreferences>(LocalPreferencesSecured());
  } else {
    Get.put<ILocalPreferences>(LocalPreferencesShared());
  }
  Get.put<ILocalAuthSource>(SimpleLocalAuthSource());
  Get.put<IAuthRepo>(AuthRepo(Get.find()));
  Get.put(AuthUseCase(Get.find()));
  Get.put(AuthController(Get.find()));
  return const MyApp();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Complete Authentication flow with shared",
      (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);

    await tester.pumpAndSettle(Durations.extralong4);

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    expect(find.byKey(const Key('loginEmail')), findsNWidgets(1));

    // go to sign in
    await tester.tap(find.byKey(const Key('loginCreateUser')));

    await tester.pumpAndSettle(Durations.extralong4);

    //verify that we are in signup page
    expect(find.byKey(const Key('signUpScaffold')), findsOneWidget);

    await tester.enterText(find.byKey(const Key('signUpEmail')), 'a@a.com');

    await tester.enterText(find.byKey(const Key('signUpPassword')), '123456');

    await tester.tap(find.byKey(const Key('signUpSubmit')));

    await tester.pumpAndSettle(Durations.extralong4);
    await tester.pumpAndSettle(Durations.extralong4);

    //expect(find.text('User ok'), findsOneWidget);

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);
    //login

    await tester.enterText(find.byKey(const Key('loginEmail')), 'b@b.com');

    await tester.enterText(find.byKey(const Key('loginPassword')), '123456');

    await tester.tap(find.byKey(const Key('loginSubmit')));

    await tester.pumpAndSettle(Durations.extralong4);

    await tester.enterText(find.byKey(const Key('loginEmail')), 'a@a.com');

    await tester.enterText(find.byKey(const Key('loginPassword')), '123456');

    await tester.tap(find.byKey(const Key('loginSubmit')));

    await tester.pumpAndSettle(Durations.extralong4);
    await tester.pumpAndSettle(Durations.extralong4);

    //verify that we are in content page
    expect(find.byKey(const Key('contentScaffold')), findsOneWidget);

    // go to profile page
    await tester.tap(find.byIcon(Icons.verified_user));
    await tester.pumpAndSettle();

    // logout
    await tester.tap(find.byKey(const Key('profileLogout')));
    await tester.pumpAndSettle();

    //verify that we are in login page
    expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

    await tester.enterText(find.byKey(const Key('loginEmail')), 'a@a.com');

    await tester.enterText(find.byKey(const Key('loginPassword')), '123456');

    await tester.tap(find.byKey(const Key('loginSubmit')));

    await tester.pumpAndSettle(Durations.extralong4);

    //verify that we are in content page
    expect(find.byKey(const Key('contentScaffold')), findsOneWidget);
  });

  // testWidgets("Authentication signup ok and login fail",
  //     (WidgetTester tester) async {
  //   Widget w = await createHomeScreen();
  //   await tester.pumpWidget(w);

  //   //verify that we are in login page
  //   expect(find.byKey(const Key('loginScaffold')), findsOneWidget);

  //   expect(find.byKey(const Key('loginEmail')), findsNWidgets(1));

  //   // go to sign in
  //   await tester.tap(find.byKey(const Key('loginCreateUser')));

  //   await tester.pumpAndSettle();

  //   //verify that we are in signup page
  //   expect(find.byKey(const Key('signUpScaffold')), findsOneWidget);

  //   await tester.enterText(find.byKey(const Key('signUpEmail')), 'a@a.com');

  //   await tester.enterText(find.byKey(const Key('signUpPassword')), '123456');

  //   await tester.tap(find.byKey(const Key('signUpSubmit')));

  //   await tester.pumpAndSettle();

  //   //expect(find.text('User ok'), findsOneWidget);

  //   //verify that we are in login page
  //   expect(find.byKey(const Key('loginScaffold')), findsOneWidget);
  //   //login
  //   await tester.enterText(find.byKey(const Key('loginEmail')), 'b@b.com');

  //   await tester.enterText(find.byKey(const Key('loginPassword')), '123456');

  //   await tester.tap(find.byKey(const Key('loginSubmit')));

  //   await tester.pumpAndSettle();

  //   //verify that we are in login page
  //   expect(find.byKey(const Key('loginScaffold')), findsOneWidget);
  // });
}
