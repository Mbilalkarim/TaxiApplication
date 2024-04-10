import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'
    show
        AuthCredential,
        FirebaseAuth,
        FirebaseAuthException,
        GoogleAuthProvider,
        PhoneAuthCredential,
        PhoneAuthProvider,
        User,
        UserCredential;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taxiapplication/Controller/authController/auth_service.dart';

import '../../Model/responseModel.dart';
import '../../firebase_options.dart';
import '../../utilities/colorconstant.dart';
import '../../utilities/debug.dart';
import '../../utilities/getStorage.dart';
import 'authException.dart';
import 'auth_provider.dart';
import 'auth_user.dart';
import 'controller/loginController.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<void> initialize() async {
    try {
      if (kIsWeb) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyC32uAz73DIrWelsGaru_RRGylqv911nTI",
              authDomain: "emergency-test-app.firebaseapp.com",
              projectId: "emergency-test-app",
              storageBucket: "emergency-test-app.appspot.com",
              messagingSenderId: "425903480653",
              appId: "1:425903480653:web:f6cc3a9b4af4a15e45a104"),
        );
      } else {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
    } catch (e) {
      debug(e);
    }
  }

  @override
  AuthUser? get currentUser {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return AuthUser.fromFirebase(user);
      } else {
        return null;
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        handleVerificationException(e); // Provide phone number if available
      }
      return null;
    }
  }

  @override
  Future<ResponseModel> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          final UserCredential authResult =
              await FirebaseAuth.instance.signInWithCredential(credential);
          storeIsNewUser(authResult.additionalUserInfo?.isNewUser ?? false);
        }
        return ResponseModel(true, "Signed in");
      } else {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithPopup(googleProvider);
        storeIsNewUser(authResult.additionalUserInfo?.isNewUser ?? false);
        return ResponseModel(true, "Signed in");
      }
    } catch (error) {
      print(error);
      return ResponseModel(false, "error $error");
    }
  }

  @override
  Future<ResponseModel> verifyOtp({required String otpCode, required String verificationId}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      var result = await FirebaseAuth.instance.signInWithCredential(credential);
      var user = currentUser;
      if (user != null) {
        storeIsNewUser(result.additionalUserInfo?.isNewUser ?? false);
        AuthService.firebase().currentUser;
        return ResponseModel(
          true,
          'OTP verification successful',
        );
      } else {
        throw FirebaseAuthException(
          code: 'unknown-error',
          message: 'Authentication failed',
        );
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        handleVerificationException(e); // Provide phone number if available
      }
      return ResponseModel(
        false,
        e.toString(),
      );
    }
  }

  @override
  Future<ResponseModel> createUserOtp({required String phoneNumber}) async {
    Completer<ResponseModel> completer = Completer<ResponseModel>();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          completer.complete(ResponseModel(true, "Verification completed"));
        },
        verificationFailed: (FirebaseAuthException e) {
          debug(e);
          LoginController cont = Get.put(LoginController());
          cont.isLoader = false;
          cont.update();
          deleteNewUser();
          handleVerificationException(e);
          completer.complete(ResponseModel(false, "Verification Failed $e"));
          throw Exception(e);
        },
        codeSent: (String verificationId, int? token) {
          storeVerificationId(verificationId);
          completer.complete(ResponseModel(true, "OTP sent successfully"));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout if needed
          LoginController cont = Get.put(LoginController());
          cont.isLoader = false;
          cont.update();
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        handleVerificationException(e);
        completer.complete(ResponseModel(false, "Verification Failed ${e.code}"));
      }
      debug(e);

      completer.complete(ResponseModel(false, "Verification Failed $e"));
    }

    return completer.future;
  }

  @override
  Future<ResponseModel> verifyOtpWeb(
      {required String otpCode, required String verificationId}) async {
    try {
      AuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpCode);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      var user = currentUser;
      if (user != null) {
        storeIsNewUser(userCredential.additionalUserInfo?.isNewUser ?? false);

        return ResponseModel(
          true,
          'OTP verification successful',
        );
      } else {
        throw FirebaseAuthException(
          code: 'unknown-error',
          message: 'Authentication failed',
        );
      }
    } catch (e) {
      return ResponseModel(false, 'Error signing in with phone number: $e');
    }
  }

  @override
  Future<ResponseModel> createUserOtpWeb({required String phoneNumber}) async {
    Completer<ResponseModel> completer = Completer<ResponseModel>();

    try {
      await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber).then((userCredential) {
        storeVerificationId(userCredential.verificationId);
        debug(userCredential.verificationId);
        // Verification completed
        completer.complete(ResponseModel(true, "Verification completed"));
      }).catchError((e) {
        // Verification failed
        print(e);
        completer.complete(ResponseModel(false, "Verification Failed $e"));
      });
    } catch (e) {
      print(e);
      completer.complete(ResponseModel(false, "Verification Failed $e"));
    }

    return completer.future;
  }

  void handleVerificationException(FirebaseAuthException e) {
    String errorMessage = e.code.replaceAll("-", " ");
    Get.snackbar(
      'Error',
      errorMessage,
      backgroundColor: AppColors.kRed,
      colorText: AppColors.kWhite,
    );

    switch (e.code) {
      case 'invalid-verification-code':
        throw InvalidVerificationCodeException('Invalid verification code');
      case 'CANNOT_BIND_TO_SERVICE':
        throw InvalidPlayStoreCodeException('CANNOT BIND TO SERVICE');
      case 'invalid-phone-number':
        throw InvalidPhoneNumber('CANNOT BIND TO SERVICE');
      case 'invalid-verification-id':
        throw InvalidVerificationIdException('Invalid verification ID');
      case 'session-expired':
        throw SessionExpiredException('Session expired');
      case 'too-many-requests':
        throw TooManyRequestsException('Too many requests');
      case 'quota-exceeded':
        throw QuotaExceededException('Quota exceeded');
      case 'credential-already-in-use':
        throw CredentialAlreadyInUseException('Credential already in use');
      case 'user-disabled':
        throw UserDisabledException('User disabled');
      case 'user-not-found':
        throw UserNotFoundException('User not found');
      case 'user-token-expired':
        throw UserTokenExpiredException('User token expired');
      case 'network-error':
        throw FirebaseAuthNetworkException('Network error');
      case 'internal-error':
        throw FirebaseAuthInternalException('Internal error');
      case 'code-auto-retrieval-timeout':
        throw CodeAutoRetrievalTimeoutException('Code auto retrieval timeout');
      case 'code-expired':
        throw CodeExpiredException('Code expired');
      case 'code-length-exception':
        throw CodeLengthException('Code length exception');
      case 'code-mismatch':
        throw CodeMismatchException('Code mismatch');
      default:
        throw FirebaseAuthNetworkException('Network error ${e.code}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if (e is FirebaseAuthException) {
        handleVerificationException(e);
      }
    }
  }
}
