import 'package:carsimmaster/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

class CommonAuth{
  Future<bool>startCommonAuthenticate(BuildContext context) async {
    LocalAuthentication localAuth = LocalAuthentication();
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    print("canCheckBiometrics $canCheckBiometrics");
    bool authResult = await localAuth.authenticateWithBiometrics(
        localizedReason: S.of(context).byd_control_please_auth);
    print('authResult $authResult');
    return authResult;
  }
}