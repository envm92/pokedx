

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Pokedx App', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    group('SignIn' , () {
      final emailSignInTextFormField = find.byValueKey('emailSignIn');
      final passwordSignInTextFormField = find.byValueKey('passwordSignIn');

      test('Write email', () async {
        await Future.delayed(const Duration(seconds: 10));
        await driver.waitFor(emailSignInTextFormField);
        await driver.tap(emailSignInTextFormField);
        await driver.enterText('test@example.com');

      });

      test('Write password', () async {
        expect(passwordSignInTextFormField, isNotNull);
        await driver.waitFor(passwordSignInTextFormField);
        await driver.enterText('123456780');

      });
    });
  });
}