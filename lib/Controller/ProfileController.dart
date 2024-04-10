import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/profileModel.dart';
import '../Model/responseModel.dart';
import '../utilities/app_utilities.dart';
import '../utilities/colorconstant.dart';
import '../utilities/debug.dart';
import '../utilities/getStorage.dart';
import 'authController/auth_service.dart';
import 'authController/crudOperations/crudOperations.dart';

class ProfileController extends GetxController with GetTickerProviderStateMixin {
  bool isSettings = false;
  FilePickerResult? filePickerResult;
  Uint8List? imageBytes, webBytes;
  bool isOwnVehicle = false;
  String selectedValue = "Captain";
  TextEditingController txtFName = TextEditingController();
  TextEditingController txtLName = TextEditingController();
  TextEditingController txtDocId = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtDob = TextEditingController();
  TextEditingController txtPhoneNumb = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtZipCode = TextEditingController();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtCnicNumber = TextEditingController();
  TextEditingController txtLicenseNo = TextEditingController();
  final FocusNode focusNodeFName = FocusNode();
  final FocusNode focusNodeLName = FocusNode();
  final FocusNode focusNodeDocId = FocusNode();
  final FocusNode focusNodeDob = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePhoneNumb = FocusNode();
  final FocusNode focusNodeAddress = FocusNode();
  final FocusNode focusNodeZipCode = FocusNode();
  final FocusNode focusNodeCity = FocusNode();
  final FocusNode focusCnic = FocusNode();
  final FocusNode focusLicenseNo = FocusNode();
  String formattedDate = "";
  int currentSteps = 0;
  bool isLoading = false, isLoadingGet = false;
  DateTime picked = DateTime.now();
  String urlImage = "", licenseUrl = "", cnicFrontUrl = "", cnicBackUrl = "";
  XFile? pickerFile;
  bool phoneReadOnly = false;

  UserModel userModel = UserModel();
  XFile? cnicFrontFile, cnicBackFile, licenseFile;
  @override
  void onClose() {
    resetToBaseValues();
    super.onClose();
  }

  @override
  Future<void> onInit() async {
    Future.delayed(const Duration(milliseconds: 700), () async {
      currentSteps = 1;
      phoneReadOnly = true;
      update();
    });

    super.onInit();
  }

  void resetToBaseValues() {
    isSettings = false;
    txtFName.clear();
    txtLName.clear();
    txtDocId.clear();
    txtEmail.clear();
    txtPhoneNumb.clear();
    txtAddress.clear();
    txtZipCode.clear();
    txtCity.clear();
    txtDob.clear();
    txtCnicNumber.clear();
    focusNodeFName.unfocus();
    focusNodeLName.unfocus();
    focusNodeDocId.unfocus();
    focusNodeEmail.unfocus();
    focusNodePhoneNumb.unfocus();
    focusNodeAddress.unfocus();
    focusNodeZipCode.unfocus();
    focusNodeCity.unfocus();
    formattedDate = "";
    currentSteps = 0;
    isLoading = false;
    isLoadingGet = false;
    picked = DateTime.now();
    urlImage = "";
    pickerFile = null;
    userModel = UserModel();
    webBytes?.clear();
  }

  Future<void> getUserData() async {
    try {
      userModel = await readUserData();
      if (userModel.userId == null || userModel.userId == "") {
        userModel = await FirestoreServices().getUserData();
        storeUserData(userModel);
      }
      // debug("this is user $user");
      isLoadingGet = true;
      update();

      txtFName.text = userModel.firstName ?? "";
      txtLName.text = userModel.lastName ?? "";
      txtEmail.text = userModel.emailAddress ?? "";
      txtPhoneNumb.text = userModel.phoneNumber ?? "";
      txtCity.text = userModel.city ?? "";
      txtAddress.text = userModel.address ?? "";
      txtZipCode.text = userModel.zipCode ?? "";
      formattedDate = userModel.dateOfBirth ?? "";
      urlImage = userModel.imageUrl ?? "";
      txtDob.text = userModel.dateOfBirth ?? "";
      txtLicenseNo.text = userModel.licenseNo ?? "";
      txtCnicNumber.text = userModel.cnicNumber ?? "";
      isOwnVehicle = userModel.isOwnVehicle ?? false;
      cnicFrontUrl = userModel.cnicFrontUrl ?? "";
      cnicBackUrl = userModel.cnicBackUrl ?? "";
      licenseUrl = userModel.licenseUrl ?? "";
      selectedValue = userModel.userType ?? "";
      isLoadingGet = false;
      update();
    } catch (e) {
      isLoadingGet = false;
      update();
      debug(e);
    }
  }

  Future<ResponseModel> setUserData(BuildContext context) async {
    String userId = AuthService.firebase().currentUser!.id;
    try {
      if (!isSettings) {
        if (selectedValue == "Captain") {
          if (pickerFile == null ||
              cnicFrontFile == null ||
              cnicBackFile == null ||
              licenseFile == null) {
            customSnackBar(
                context, AppColors.kRed, AppColors.kWhite, 'Please upload required images');

            return ResponseModel(false, "Please upload an image to save");
          }
          isLoading = true;
          update();
          if (pickerFile != null) {
            urlImage =
                await FirestoreServices().uploadImage("$userId/userImage/", File(pickerFile!.path));
            cnicFrontUrl = await FirestoreServices()
                .uploadImage("$userId/cnic/front/", File(cnicFrontFile!.path));
            cnicBackUrl = await FirestoreServices()
                .uploadImage("$userId/cnic/back/", File(cnicBackFile!.path));
            licenseUrl =
                await FirestoreServices().uploadImage("$userId/license/", File(licenseFile!.path));
          } else if (urlImage == "" || urlImage.isEmpty) {
            customSnackBar(context, AppColors.kRed, AppColors.kWhite, 'Please upload an image');
            isLoading = false;
            update();
            return ResponseModel(false, "Please upload an image to save");
          } else {
            isLoading = false;
            update();
            return ResponseModel(false, "Please upload an image to save");
          }
        } else {
          if (pickerFile == null) {
            customSnackBar(
                context, AppColors.kRed, AppColors.kWhite, 'Please upload required images');

            return ResponseModel(false, "Please upload an image to save");
          }
        }
        isLoading = true;
        update();
        if (pickerFile != null) {
          urlImage =
              await FirestoreServices().uploadImage("$userId/userImage/", File(pickerFile!.path));
        } else if (urlImage == "" || urlImage.isEmpty) {
          customSnackBar(context, AppColors.kRed, AppColors.kWhite, 'Please upload an image');
          isLoading = false;
          update();
          return ResponseModel(false, "Please upload an image to save");
        } else {
          isLoading = false;
          update();
          return ResponseModel(false, "Please upload an image to save");
        }
      } else {
        if (pickerFile != null) {
          urlImage =
              await FirestoreServices().uploadImage("$userId/userImage/", File(pickerFile!.path));
        }
      }

      isLoading = true;
      update();
      UserModel userModel = UserModel(
          userId: AuthService.firebase().currentUser?.id,
          firstName: txtFName.text,
          lastName: txtLName.text,
          phoneNumber: txtPhoneNumb.text,
          address: txtAddress.text,
          city: txtCity.text,
          emailAddress: txtEmail.text,
          zipCode: txtZipCode.text,
          dateOfBirth: formattedDate,
          imageUrl: urlImage,
          cnicNumber: txtCnicNumber.text,
          cnicBackUrl: cnicBackUrl,
          cnicFrontUrl: cnicFrontUrl,
          licenseNo: txtLicenseNo.text,
          licenseUrl: licenseUrl,
          isOwnVehicle: isOwnVehicle,
          userType: selectedValue);

      await FirestoreServices().setUserData(userModel);
      isLoading = false;
      update();
      return ResponseModel(true, "Data saved");
    } catch (e) {
      isLoading = false;
      customSnackBar(context, AppColors.kRed, AppColors.kWhite, 'Unexpected Error Occurred');
      update();
      debug(e);
      return ResponseModel(false, "Unexpected Error Occurred");
    }
  }

  bool validate(BuildContext context) {
    if (selectedValue == "Captain") {
      if (txtCity.text.trim().isEmpty ||
          txtZipCode.text.trim().isEmpty ||
          txtAddress.text.trim().isEmpty ||
          txtPhoneNumb.text.trim().isEmpty ||
          txtCnicNumber.text.trim().isEmpty ||
          txtLicenseNo.text.trim().isEmpty ||
          txtLName.text.trim().isEmpty ||
          txtFName.text.trim().isEmpty ||
          formattedDate.isEmpty ||
          formattedDate == "") {
        customSnackBar(context, AppColors.kRed, AppColors.kWhite, 'Please Enter all fields');

        return false;
      } else {
        return true;
      }
    } else {
      if (txtCity.text.trim().isEmpty ||
          txtZipCode.text.trim().isEmpty ||
          txtAddress.text.trim().isEmpty ||
          txtPhoneNumb.text.trim().isEmpty ||
          txtLName.text.trim().isEmpty ||
          txtFName.text.trim().isEmpty ||
          formattedDate.isEmpty ||
          formattedDate == "") {
        customSnackBar(context, AppColors.kRed, AppColors.kWhite, 'Please Enter all fields');

        return false;
      } else {
        return true;
      }
    }
  }

  Future<DateTime> selectDate(BuildContext context) async {
    picked = await showDatePicker(
          context: context,
          lastDate: DateTime.now().subtract(Duration(days: 365)),
          firstDate: DateTime(1940),
        ) ??
        DateTime.now();
    formattedDate = formatDate(picked);
    txtDob.text = formattedDate;
    update();
    return picked;
  }
}
