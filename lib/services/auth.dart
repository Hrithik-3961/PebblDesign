import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verId = "", smsCode = "";
  bool codeSent = false;

  Future register() async {}

  Future<void> verifyNum(num) async {
    signIn(AuthCredential authCreds) {
      FirebaseAuth.instance.signInWithCredential(authCreds);
    }

    //for manual otp entry
    signInViaOTP(smsCode, verId) {
      AuthCredential authCredential =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
      signIn(authCredential);
    }

    final PhoneVerificationCompleted verified = (AuthCredential authRes) {
      signIn(authRes);
    };
    final PhoneVerificationFailed failed = (authException) {};
    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) {
      this.verId = verId;
      this.codeSent = true;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verId) {
      this.verId = verId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: num,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: failed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeOut);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
