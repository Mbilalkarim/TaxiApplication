import '../../Model/responseModel.dart';
import 'auth_provider.dart';
import 'auth_user.dart';
import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<ResponseModel> createUserOtp({required String phoneNumber}) async =>
      await provider.createUserOtp(phoneNumber: phoneNumber);

  @override
  Future<ResponseModel> verifyOtp(
          {required String otpCode, required String verificationId}) async =>
      await provider.verifyOtp(otpCode: otpCode, verificationId: verificationId);
  @override
  Future<ResponseModel> verifyOtpWeb(
          {required String otpCode, required String verificationId}) async =>
      await provider.verifyOtp(otpCode: otpCode, verificationId: verificationId);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<ResponseModel> signInWithGoogle() => provider.signInWithGoogle();

  @override
  Future<ResponseModel> createUserOtpWeb({required String phoneNumber}) =>
      provider.createUserOtpWeb(phoneNumber: phoneNumber);
}
