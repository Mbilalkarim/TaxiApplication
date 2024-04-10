import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxiapplication/Views/dashboaard/dashboardView.dart';
import 'package:taxiapplication/utilities/customWidgets/customDropdown.dart';

import '../../Controller/ProfileController.dart';
import '../../Controller/authController/auth_service.dart';
import '../../Model/responseModel.dart';
import '../../utilities/colorconstant.dart';
import '../../utilities/customDialog/custom_dialog_mobile.dart';
import '../../utilities/customWidgets/customAppBarr.dart';
import '../../utilities/customWidgets/customButtom.dart';
import '../../utilities/customWidgets/customInfoWidget.dart';
import '../../utilities/customWidgets/progressBar.dart';
import '../../utilities/dimensions.dart';
import '../../utilities/fontsizes.dart';
import '../../utilities/images.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (_) {
          _.txtPhoneNumb.text = AuthService.firebase().currentUser?.phone ?? "";
          return AbsorbPointer(
            absorbing: _.isLoading,
            child: PopScope(
              canPop: true,
              onPopInvoked: (didPop) {
                _.getUserData();
              },
              child: Scaffold(
                appBar: CustomAppBar(
                  isBack: _.isSettings ? true : false,
                  onBack: () async {
                    Get.back();
                    await _.getUserData();
                  },
                  titleStr: AppLocalizations.of(context)!.personalInformation,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(2),
                    child: Divider(
                      height: 10,
                      color: AppColors.kGrey.withOpacity(0.5),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_24),
                    child: Column(
                      children: [
                        Dimensions.PADDING_SIZE_8.spaceY,
                        if (!_.isSettings)
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_16),
                              child: CustomLinearProgressBar(
                                totalSteps: 2,
                                completedSteps: _.currentSteps,
                              )),
                        Dimensions.PADDING_SIZE_12.spaceY,
                        Dimensions.PADDING_SIZE_8.spaceY,
                        if (!_.isSettings)
                          CustomDropdown(
                            items: [
                              "Passenger",
                              "Captain",
                            ],
                            selectedValue: _.selectedValue,
                            onChanged: (value) {
                              if (value != null) {
                                _.selectedValue = value.toString();
                              }
                              _.currentSteps = 1;
                              _.update();
                            },
                          ),
                        Dimensions.PADDING_SIZE_8.spaceY,
                        _.selectedValue == "Captain"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        _.pickerFile != null
                                            ? Container(
                                                width: 120,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: FileImage(File(_.pickerFile!.path)),
                                                      fit: BoxFit.cover),
                                                ))
                                            : _.urlImage == "" || _.urlImage.isEmpty
                                                ? Container(
                                                    width: 120,
                                                    height: 120,
                                                    alignment: Alignment.center,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: AssetImage(Images.person_png),
                                                          fit: BoxFit.cover),
                                                    ))
                                                : ClipOval(
                                                    child: Material(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: Image.network(
                                                        _.urlImage,
                                                        fit: BoxFit.cover,
                                                        width: 120,
                                                        height: 120,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return Container(
                                                            width: 120,
                                                            height: 120,
                                                            padding: const EdgeInsets.all(4),
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(50),
                                                              image: const DecorationImage(
                                                                  image:
                                                                      AssetImage(Images.person_png),
                                                                  fit: BoxFit.cover),
                                                            ),
                                                          );
                                                        },
                                                        loadingBuilder: (BuildContext context,
                                                            Widget child,
                                                            ImageChunkEvent? loadingProgress) {
                                                          if (loadingProgress == null) {
                                                            return Container(
                                                              width: 120,
                                                              height: 120,
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(50),
                                                              ),
                                                              child: child,
                                                            );
                                                          }
                                                          return SizedBox(
                                                            width: 120,
                                                            height: 120,
                                                            child: Center(
                                                              child: CircularProgressIndicator(
                                                                value: loadingProgress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes!
                                                                    : null,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                        Dimensions.PADDING_SIZE_8.spaceY,
                                        InkWell(
                                          onTap: () async {
                                            if (!kIsWeb) {
                                              await customDialog(
                                                context,
                                              ).then((value) async {
                                                if (value != "") {
                                                  if (value == "gallery") {
                                                    final XFile? image = await ImagePicker()
                                                        .pickImage(source: ImageSource.gallery);
                                                    if (image != null) {
                                                      _.pickerFile = image;
                                                      _.urlImage = "";
                                                      _.update();
                                                    }
                                                  } else if (value == "camera") {
                                                    final XFile? image = await ImagePicker()
                                                        .pickImage(source: ImageSource.camera);

                                                    if (image != null) {
                                                      _.pickerFile = image;
                                                      _.urlImage = "";
                                                      _.update();
                                                    }
                                                  }
                                                }
                                              });
                                            } else {
                                              _.filePickerResult =
                                                  await FilePicker.platform.pickFiles(
                                                allowMultiple: false,
                                                type: FileType.image,
                                                withData: true,
                                              );

                                              if (_.filePickerResult != null) {
                                                _.imageBytes =
                                                    _.filePickerResult!.files.single.bytes;
                                                String base64Image = base64Encode(_.imageBytes!);
                                                _.urlImage = 'data:image/jpeg;base64,$base64Image';
                                                _.update();
                                              }
                                            }
                                            _.currentSteps = 1;
                                            _.update();
                                          },
                                          child: Text(
                                            _.isSettings
                                                ? AppLocalizations.of(context)!.edit
                                                : AppLocalizations.of(context)!.upload,
                                            style: FontSize.txtPop16_800
                                                .copyWith(color: AppColors.kPrimary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Dimensions.PADDING_SIZE_16.spaceY,

                                  Dimensions.PADDING_SIZE_16.spaceY,
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.firstName,
                                      hintText: AppLocalizations.of(context)!.enterFirstName,
                                      focusNode: _.focusNodeFName,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeLName);
                                      },
                                      controller: _.txtFName),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.lastName,
                                      hintText: AppLocalizations.of(context)!.enterLastName,
                                      focusNode: _.focusNodeLName,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusCnic);
                                      },
                                      controller: _.txtLName),

                                  CustomInfoWidget(
                                      heading: "Cnic Number",
                                      hintText: "Enter your 16 digit Cnic",
                                      focusNode: _.focusCnic,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                      ],
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusLicenseNo);
                                      },
                                      controller: _.txtCnicNumber),
                                  Dimensions.PADDING_SIZE_8.spaceY,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            _.cnicFrontFile != null
                                                ? Image.file(
                                                    File(_.cnicFrontFile!.path),
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                  )
                                                : _.cnicFrontUrl != "" || _.cnicFrontUrl.isNotEmpty
                                                    ? ClipOval(
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(50),
                                                          child: Image.network(
                                                            _.cnicFrontUrl,
                                                            fit: BoxFit.cover,
                                                            width: 120,
                                                            height: 120,
                                                            errorBuilder:
                                                                (context, error, stackTrace) {
                                                              return Container(
                                                                height: 100,
                                                                color: AppColors.kGrey
                                                                    .withOpacity(0.1),
                                                              );
                                                            },
                                                            loadingBuilder: (BuildContext context,
                                                                Widget child,
                                                                ImageChunkEvent? loadingProgress) {
                                                              if (loadingProgress == null) {
                                                                return Container(
                                                                  width: 120,
                                                                  height: 120,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(50),
                                                                  ),
                                                                  child: child,
                                                                );
                                                              }
                                                              return SizedBox(
                                                                width: 120,
                                                                height: 120,
                                                                child: Center(
                                                                  child: CircularProgressIndicator(
                                                                    value: loadingProgress
                                                                                .expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress
                                                                                .cumulativeBytesLoaded /
                                                                            loadingProgress
                                                                                .expectedTotalBytes!
                                                                        : null,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 100,
                                                        color: AppColors.kGrey.withOpacity(0.1),
                                                      ),
                                            Dimensions.PADDING_SIZE_8.spaceY,
                                            if (!_.isSettings)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  CustomButton(
                                                      onTap: () async {
                                                        await customDialog(
                                                          context,
                                                        ).then((value) async {
                                                          if (value != "") {
                                                            if (value == "gallery") {
                                                              final XFile? image =
                                                                  await ImagePicker().pickImage(
                                                                      source: ImageSource.gallery);
                                                              if (image != null) {
                                                                _.cnicFrontFile = image;
                                                                _.update();
                                                              }
                                                            } else if (value == "camera") {
                                                              final XFile? image =
                                                                  await ImagePicker().pickImage(
                                                                      source: ImageSource.camera);

                                                              if (image != null) {
                                                                _.cnicFrontFile = image;
                                                                _.update();
                                                              }
                                                            }
                                                          }
                                                        });
                                                        _.currentSteps = 1;
                                                        _.update();
                                                      },
                                                      text: "Upload front"),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                      Dimensions.PADDING_SIZE_8.spaceX,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            _.cnicBackFile != null
                                                ? Image.file(
                                                    File(_.cnicBackFile!.path),
                                                    height: 140,
                                                    fit: BoxFit.cover,
                                                  )
                                                : _.cnicBackUrl != "" || _.cnicBackUrl.isNotEmpty
                                                    ? ClipOval(
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(50),
                                                          child: Image.network(
                                                            _.cnicBackUrl,
                                                            fit: BoxFit.cover,
                                                            width: 120,
                                                            height: 120,
                                                            errorBuilder:
                                                                (context, error, stackTrace) {
                                                              return Container(
                                                                height: 100,
                                                                color: AppColors.kGrey
                                                                    .withOpacity(0.1),
                                                              );
                                                            },
                                                            loadingBuilder: (BuildContext context,
                                                                Widget child,
                                                                ImageChunkEvent? loadingProgress) {
                                                              if (loadingProgress == null) {
                                                                return Container(
                                                                  width: 120,
                                                                  height: 120,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(50),
                                                                  ),
                                                                  child: child,
                                                                );
                                                              }
                                                              return SizedBox(
                                                                width: 120,
                                                                height: 120,
                                                                child: Center(
                                                                  child: CircularProgressIndicator(
                                                                    value: loadingProgress
                                                                                .expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress
                                                                                .cumulativeBytesLoaded /
                                                                            loadingProgress
                                                                                .expectedTotalBytes!
                                                                        : null,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 100,
                                                        color: AppColors.kGrey.withOpacity(0.1),
                                                      ),
                                            Dimensions.PADDING_SIZE_8.spaceY,
                                            if (!_.isSettings)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  CustomButton(
                                                      onTap: () async {
                                                        await customDialog(
                                                          context,
                                                        ).then((value) async {
                                                          if (value != "") {
                                                            if (value == "gallery") {
                                                              final XFile? image =
                                                                  await ImagePicker().pickImage(
                                                                      source: ImageSource.gallery);
                                                              if (image != null) {
                                                                _.cnicBackFile = image;
                                                                _.update();
                                                              }
                                                            } else if (value == "camera") {
                                                              final XFile? image =
                                                                  await ImagePicker().pickImage(
                                                                      source: ImageSource.camera);

                                                              if (image != null) {
                                                                _.cnicBackFile = image;
                                                                _.update();
                                                              }
                                                            }
                                                          }
                                                        });
                                                        _.currentSteps = 1;
                                                        _.update();
                                                      },
                                                      text: "Upload Back"),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Dimensions.PADDING_SIZE_16.spaceY,
                                  CustomInfoWidget(
                                      heading: "License Number",
                                      hintText: "Enter your 16 digit License No.",
                                      focusNode: _.focusLicenseNo,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                      ],
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeEmail);
                                      },
                                      controller: _.txtLicenseNo),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      _.licenseFile != null
                                          ? Image.file(
                                              File(_.licenseFile!.path),
                                              height: 150,
                                              fit: BoxFit.cover,
                                            )
                                          : _.licenseUrl != "" || _.licenseUrl.isNotEmpty
                                              ? ClipOval(
                                                  child: Material(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: Image.network(
                                                      _.licenseUrl,
                                                      fit: BoxFit.cover,
                                                      width: 120,
                                                      height: 120,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Container(
                                                          height: 100,
                                                          color: AppColors.kGrey.withOpacity(0.1),
                                                        );
                                                      },
                                                      loadingBuilder: (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent? loadingProgress) {
                                                        if (loadingProgress == null) {
                                                          return Container(
                                                            width: 120,
                                                            height: 120,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(50),
                                                            ),
                                                            child: child,
                                                          );
                                                        }
                                                        return SizedBox(
                                                          width: 120,
                                                          height: 120,
                                                          child: Center(
                                                            child: CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 100,
                                                  color: AppColors.kGrey.withOpacity(0.1),
                                                ),
                                      Dimensions.PADDING_SIZE_8.spaceY,
                                      if (!_.isSettings)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                                onTap: () async {
                                                  await customDialog(
                                                    context,
                                                  ).then((value) async {
                                                    if (value != "") {
                                                      if (value == "gallery") {
                                                        final XFile? image = await ImagePicker()
                                                            .pickImage(source: ImageSource.gallery);
                                                        if (image != null) {
                                                          _.licenseFile = image;
                                                          _.update();
                                                        }
                                                      } else if (value == "camera") {
                                                        final XFile? image = await ImagePicker()
                                                            .pickImage(source: ImageSource.camera);

                                                        if (image != null) {
                                                          _.licenseFile = image;
                                                          _.update();
                                                        }
                                                      }
                                                    }
                                                  });
                                                  _.currentSteps = 1;
                                                  _.update();
                                                },
                                                text: "Upload License"),
                                          ],
                                        )
                                    ],
                                  ),
                                  Dimensions.PADDING_SIZE_16.spaceY,
                                  RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        text: "Do you have your own vehicle",
                                        style:
                                            FontSize.txtPop14_600.copyWith(color: AppColors.kBlack),
                                        children: [
                                          TextSpan(
                                              text: ' *',
                                              style: FontSize.txtPop14_600
                                                  .copyWith(color: AppColors.kBlack)),
                                        ]),
                                    maxLines: 1,
                                  ),
                                  Dimensions.PADDING_SIZE_8.spaceY,
                                  CustomDropdown(
                                      items: const ["Yes", "No"],
                                      selectedValue: _.isOwnVehicle ? "Yes" : "No",
                                      onChanged: (value) {
                                        if (value == "Yes") {
                                          _.isOwnVehicle = true;
                                        } else {
                                          _.isOwnVehicle = false;
                                        }
                                      }),
                                  Dimensions.PADDING_SIZE_16.spaceY,

                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.emailAddress,
                                      hintText: AppLocalizations.of(context)!.enterEmailAddress,
                                      focusNode: _.focusNodeEmail,
                                      textCapitalization: TextCapitalization.none,
                                      textInputAction: TextInputAction.next,
                                      isMandatory: false,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeAddress);
                                      },
                                      controller: _.txtEmail),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.dateOfBirth,
                                      hintText: AppLocalizations.of(context)!.dateOfBirth,
                                      focusNode: _.focusNodeDob,
                                      isReadOnly: true,
                                      onTap: () {
                                        _.selectDate(context);
                                      },
                                      controller: _.txtDob),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           AppLocalizations.of(context)!.dateOfBirth,
                                  //           style: FontSize.txtPop16_800,
                                  //         ),
                                  //         Dimensions.PADDING_SIZE_8.spaceY,
                                  //         InkWell(
                                  //           onTap: () {
                                  //             _.selectDate(context);
                                  //           },
                                  //           child: Material(
                                  //             elevation: 2,
                                  //             surfaceTintColor: AppColors.kWhite,
                                  //             borderRadius: BorderRadius.circular(12),
                                  //             child: Container(
                                  //               decoration:
                                  //                   BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                  //               margin: const EdgeInsets.symmetric(
                                  //                   horizontal: Dimensions.PADDING_SIZE_32,
                                  //                   vertical: Dimensions.PADDING_SIZE_10),
                                  //               child: Text(_.formattedDate == ""
                                  //                   ? "Press here to select date"
                                  //                   : _.formattedDate),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         Dimensions.PADDING_SIZE_10.spaceY,
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.contact,
                                      hintText: AppLocalizations.of(context)!.enterContact,
                                      isReadOnly: _.phoneReadOnly,
                                      controller: _.txtPhoneNumb),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.streetNHouse,
                                      hintText: AppLocalizations.of(context)!.enterStreetNHouse,
                                      focusNode: _.focusNodeAddress,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeZipCode);
                                      },
                                      controller: _.txtAddress),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.zipCode,
                                      hintText: AppLocalizations.of(context)!.zipCode,
                                      keyboardType: TextInputType.phone,
                                      focusNode: _.focusNodeZipCode,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeCity);
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                      ],
                                      controller: _.txtZipCode),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.city,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                      ],
                                      hintText: AppLocalizations.of(context)!.enterCity,
                                      focusNode: _.focusNodeCity,
                                      textInputAction: TextInputAction.done,
                                      controller: _.txtCity),
                                  Dimensions.PADDING_SIZE_16.spaceY,
                                  // Row(
                                  //   children: [
                                  //     Checkbox(value: true, onChanged: (check) {}),
                                  //     Dimensions.PADDING_SIZE_8.spaceX,
                                  //     const Flexible(
                                  //       child: Text(
                                  //         "Receive Important Email Notifications",
                                  //         maxLines: 2,
                                  //         style: FontSize.txtPop14_500,
                                  //         overflow: TextOverflow.clip,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Dimensions.PADDING_SIZE_16.spaceY,
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Dimensions.PADDING_SIZE_8.spaceY,

                                  Dimensions.PADDING_SIZE_12.spaceY,
                                  _.pickerFile != null
                                      ? Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: FileImage(File(_.pickerFile!.path)),
                                                fit: BoxFit.cover),
                                          ))
                                      : _.webBytes != null
                                          ? SizedBox(
                                              height: 120,
                                              width: 120,
                                              child: Container(
                                                width: 120,
                                                height: 120,
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  image: DecorationImage(
                                                      image: MemoryImage(_.webBytes!)),
                                                ),
                                              ))
                                          : _.urlImage == "" || _.urlImage.isEmpty
                                              ? Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: AssetImage(Images.person_png),
                                                        fit: BoxFit.cover),
                                                  ))
                                              : ClipOval(
                                                  child: Material(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: Image.network(
                                                      _.urlImage,
                                                      fit: BoxFit.cover,
                                                      width: 120,
                                                      height: 120,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Container(
                                                          width: 120,
                                                          height: 120,
                                                          padding: const EdgeInsets.all(4),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(50),
                                                            image: const DecorationImage(
                                                                image:
                                                                    AssetImage(Images.person_png),
                                                                fit: BoxFit.cover),
                                                          ),
                                                        );
                                                      },
                                                      loadingBuilder: (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent? loadingProgress) {
                                                        if (loadingProgress == null) {
                                                          return Container(
                                                            width: 120,
                                                            height: 120,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(50),
                                                            ),
                                                            child: child,
                                                          );
                                                        }
                                                        return SizedBox(
                                                          width: 120,
                                                          height: 120,
                                                          child: Center(
                                                            child: CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                  Dimensions.PADDING_SIZE_8.spaceY,
                                  InkWell(
                                    onTap: () async {
                                      if (!kIsWeb) {
                                        await customDialog(
                                          context,
                                        ).then((value) async {
                                          if (value != "") {
                                            if (value == "gallery") {
                                              final XFile? image = await ImagePicker()
                                                  .pickImage(source: ImageSource.gallery);
                                              if (image != null) {
                                                _.pickerFile = image;
                                                _.urlImage = "";
                                                _.update();
                                              }
                                            } else if (value == "camera") {
                                              final XFile? image = await ImagePicker()
                                                  .pickImage(source: ImageSource.camera);

                                              if (image != null) {
                                                _.pickerFile = image;
                                                _.urlImage = "";
                                                _.update();
                                              }
                                            }
                                          }
                                        });
                                      } else {
                                        _.filePickerResult = await FilePicker.platform.pickFiles(
                                          allowMultiple: false,
                                          type: FileType.image,
                                          withData: true,
                                        );

                                        if (_.filePickerResult != null) {
                                          _.imageBytes = _.filePickerResult!.files.single.bytes;
                                          String base64Image = base64Encode(_.imageBytes!);
                                          _.urlImage = 'data:image/jpeg;base64,$base64Image';
                                          _.update();
                                        }
                                      }
                                      _.currentSteps = 1;
                                      _.update();
                                    },
                                    child: Text(
                                      _.isSettings
                                          ? AppLocalizations.of(context)!.edit
                                          : AppLocalizations.of(context)!.upload,
                                      style:
                                          FontSize.txtPop16_800.copyWith(color: AppColors.kSkyBlue),
                                    ),
                                  ),
                                  Dimensions.PADDING_SIZE_16.spaceY,
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     CustomDropdown<String>(
                                  //       items: const ['Option 1', 'Option 2', 'Option 3'],
                                  //       selectedValue: 'Option 1', // Set the initial selected value
                                  //       onChanged: (String? value) {
                                  //         _.dropDownValue = value ?? "";
                                  //         debug("dropdown value${_.dropDownValue}");
                                  //         // Do something with the selected value
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),

                                  Dimensions.PADDING_SIZE_16.spaceY,
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.firstName,
                                      hintText: AppLocalizations.of(context)!.enterFirstName,
                                      focusNode: _.focusNodeFName,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeLName);
                                      },
                                      controller: _.txtFName),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.lastName,
                                      hintText: AppLocalizations.of(context)!.enterLastName,
                                      focusNode: _.focusNodeLName,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeEmail);
                                      },
                                      controller: _.txtLName),

                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.emailAddress,
                                      hintText: AppLocalizations.of(context)!.enterEmailAddress,
                                      focusNode: _.focusNodeEmail,
                                      textCapitalization: TextCapitalization.none,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeAddress);
                                      },
                                      controller: _.txtEmail),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.dateOfBirth,
                                      hintText: AppLocalizations.of(context)!.dateOfBirth,
                                      focusNode: _.focusNodeDob,
                                      isReadOnly: true,
                                      onTap: () {
                                        _.selectDate(context);
                                      },
                                      controller: _.txtDob),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           AppLocalizations.of(context)!.dateOfBirth,
                                  //           style: FontSize.txtPop16_800,
                                  //         ),
                                  //         Dimensions.PADDING_SIZE_8.spaceY,
                                  //         InkWell(
                                  //           onTap: () {
                                  //             _.selectDate(context);
                                  //           },
                                  //           child: Material(
                                  //             elevation: 2,
                                  //             surfaceTintColor: AppColors.kWhite,
                                  //             borderRadius: BorderRadius.circular(12),
                                  //             child: Container(
                                  //               decoration:
                                  //                   BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                  //               margin: const EdgeInsets.symmetric(
                                  //                   horizontal: Dimensions.PADDING_SIZE_32,
                                  //                   vertical: Dimensions.PADDING_SIZE_10),
                                  //               child: Text(_.formattedDate == ""
                                  //                   ? "Press here to select date"
                                  //                   : _.formattedDate),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         Dimensions.PADDING_SIZE_10.spaceY,
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.contact,
                                      hintText: AppLocalizations.of(context)!.enterContact,
                                      isReadOnly: _.phoneReadOnly,
                                      controller: _.txtPhoneNumb),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.streetNHouse,
                                      hintText: AppLocalizations.of(context)!.enterStreetNHouse,
                                      focusNode: _.focusNodeAddress,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeZipCode);
                                      },
                                      controller: _.txtAddress),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.zipCode,
                                      hintText: AppLocalizations.of(context)!.zipCode,
                                      keyboardType: TextInputType.phone,
                                      focusNode: _.focusNodeZipCode,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).requestFocus(_.focusNodeCity);
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                      ],
                                      controller: _.txtZipCode),
                                  CustomInfoWidget(
                                      heading: AppLocalizations.of(context)!.city,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                      ],
                                      hintText: AppLocalizations.of(context)!.enterCity,
                                      focusNode: _.focusNodeCity,
                                      textInputAction: TextInputAction.done,
                                      controller: _.txtCity),
                                  Dimensions.PADDING_SIZE_16.spaceY,
                                  // Row(
                                  //   children: [
                                  //     Checkbox(value: true, onChanged: (check) {}),
                                  //     Dimensions.PADDING_SIZE_8.spaceX,
                                  //     const Flexible(
                                  //       child: Text(
                                  //         "Receive Important Email Notifications",
                                  //         maxLines: 2,
                                  //         style: FontSize.txtPop14_500,
                                  //         overflow: TextOverflow.clip,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Dimensions.PADDING_SIZE_16.spaceY,
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                    margin: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_16),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              isLoader: _.isLoading,
                              onTap: () async {
                                if (_.validate(context)) {
                                  ResponseModel response = await _.setUserData(context);
                                  if (response.isSuccess) {
                                    if (!_.isSettings) {
                                      Get.offAll(const DashboardView());
                                    }
                                  }
                                }
                              },
                              text: "Save Profile",
                              horizontal: 20,
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          );
        });
  }
}
