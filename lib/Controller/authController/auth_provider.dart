import '../../Model/responseModel.dart';
import 'auth_user.dart';

abstract class AuthProvider {
  Future<ResponseModel> createUserOtp({required String phoneNumber});
  Future<ResponseModel> createUserOtpWeb({required String phoneNumber});
  Future<void> initialize();
  Future<ResponseModel> verifyOtp({required String otpCode, required String verificationId});
  Future<ResponseModel> verifyOtpWeb({required String otpCode, required String verificationId});
  AuthUser? get currentUser;
  Future<void> logout();
  Future<ResponseModel> signInWithGoogle();
}
