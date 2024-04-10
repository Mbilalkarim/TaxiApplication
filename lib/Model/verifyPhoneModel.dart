import 'package:taxiapplication/Model/responseModel.dart';

class VerifyPhoneNoModel {
  final String? verificationId;
  final ResponseModel? responseModel;
  final bool? isNewUser;

  VerifyPhoneNoModel({
    this.verificationId,
    this.responseModel,
    this.isNewUser,
  });
  @override
  String toString() {
    return 'VerifyPhoneNoModel{verificationId: $verificationId, responseModel: $responseModel, isNewUser : $isNewUser}';
  }
}
