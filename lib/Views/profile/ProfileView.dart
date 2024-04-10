import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/utilities/extensions.dart';

import '../../Controller/ProfileController.dart';
import '../../Controller/dashboardController.dart';
import '../../utilities/colorconstant.dart';
import '../../utilities/customWidgets/customAppBarr.dart';
import '../../utilities/customWidgets/customInfoWidget.dart';
import '../../utilities/dimensions.dart';
import '../../utilities/fontsizes.dart';
import '../../utilities/images.dart';
import 'ProfileEdit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (_) {
          return AbsorbPointer(
            absorbing: _.isLoadingGet,
            child: Scaffold(
              appBar: CustomAppBar(
                onBack: () async {
                  Get.put(DashboardController());
                  Get.find<DashboardController>().getUserData();
                  Get.back();
                },
                titleStr: AppLocalizations.of(context)!.personalInformation,
                actions: [
                  Container(
                    padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_16),
                    child: InkWell(
                      onTap: () {
                        Get.put(ProfileController());
                        Get.find<ProfileController>().isSettings = true;
                        Get.myGetTo(const ProfileEdit());
                      },
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: FontSize.txtPop16_800.copyWith(color: AppColors.kSkyBlue),
                      ),
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(2),
                  child: Divider(
                    height: 10,
                    color: AppColors.kGrey.withOpacity(0.5),
                  ),
                ),
              ),
              body: PopScope(
                canPop: true,
                onPopInvoked: (didPop) {
                  Get.put(DashboardController());
                  Get.find<DashboardController>().getUserData();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_24),
                    child: _.selectedValue == "Captain"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Dimensions.PADDING_SIZE_8.spaceY,

                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _.urlImage == "" || _.urlImage.isEmpty
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
                                                      borderRadius: BorderRadius.circular(50),
                                                      image: const DecorationImage(
                                                          image: AssetImage(Images.person_png),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  );
                                                },
                                                loadingBuilder: (BuildContext context, Widget child,
                                                    ImageChunkEvent? loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return Container(
                                                      width: 120,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                      ),
                                                      child: child,
                                                    );
                                                  }
                                                  return SizedBox(
                                                    width: 120,
                                                    height: 120,
                                                    child: Center(
                                                      child: CircularProgressIndicator(
                                                        value: loadingProgress.expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress.expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                    Dimensions.PADDING_SIZE_8.spaceY,
                                  ],
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
                                  isReadOnly: true,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(_.focusNodeLName);
                                  },
                                  controller: _.txtFName),
                              CustomInfoWidget(
                                  heading: AppLocalizations.of(context)!.lastName,
                                  hintText: AppLocalizations.of(context)!.enterLastName,
                                  isReadOnly: true,
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
                                  isReadOnly: true,
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
                                        _.cnicFrontUrl != "" || _.cnicFrontUrl.isNotEmpty
                                            ? ClipOval(
                                                child: Material(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.network(
                                                    _.cnicFrontUrl,
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
                                                            borderRadius: BorderRadius.circular(50),
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
                                      ],
                                    ),
                                  ),
                                  Dimensions.PADDING_SIZE_8.spaceX,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        _.cnicBackUrl != "" || _.cnicBackUrl.isNotEmpty
                                            ? ClipOval(
                                                child: Material(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.network(
                                                    _.cnicBackUrl,
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
                                                            borderRadius: BorderRadius.circular(50),
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
                                  isReadOnly: true,
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
                                  _.licenseUrl != "" || _.licenseUrl.isNotEmpty
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
                                              loadingBuilder: (BuildContext context, Widget child,
                                                  ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return Container(
                                                    width: 120,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                    child: child,
                                                  );
                                                }
                                                return SizedBox(
                                                  width: 120,
                                                  height: 120,
                                                  child: Center(
                                                    child: CircularProgressIndicator(
                                                      value: loadingProgress.expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                              loadingProgress.expectedTotalBytes!
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
                                ],
                              ),
                              Dimensions.PADDING_SIZE_16.spaceY,
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                    text: "Do you have your own vehicle",
                                    style: FontSize.txtPop14_600.copyWith(color: AppColors.kBlack),
                                    children: [
                                      TextSpan(
                                          text: ' *',
                                          style: FontSize.txtPop14_600
                                              .copyWith(color: AppColors.kBlack)),
                                    ]),
                                maxLines: 1,
                              ),
                              Dimensions.PADDING_SIZE_8.spaceY,
                              Container(
                                decoration:
                                    BoxDecoration(border: Border.all(color: AppColors.kGrey)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.PADDING_SIZE_16,
                                    vertical: Dimensions.PADDING_SIZE_10),
                                child: Text(_.isOwnVehicle ? "Yes" : "No"),
                              ),
                              Dimensions.PADDING_SIZE_16.spaceY,

                              CustomInfoWidget(
                                  heading: AppLocalizations.of(context)!.emailAddress,
                                  hintText: AppLocalizations.of(context)!.enterEmailAddress,
                                  focusNode: _.focusNodeEmail,
                                  textCapitalization: TextCapitalization.none,
                                  isReadOnly: true,
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
                                  keyboardType: TextInputType.phone,
                                  isReadOnly: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
                                  controller: _.txtPhoneNumb),
                              CustomInfoWidget(
                                  heading: AppLocalizations.of(context)!.streetNHouse,
                                  hintText: AppLocalizations.of(context)!.enterStreetNHouse,
                                  focusNode: _.focusNodeAddress,
                                  isReadOnly: true,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(_.focusNodeZipCode);
                                  },
                                  controller: _.txtAddress),
                              CustomInfoWidget(
                                  heading: AppLocalizations.of(context)!.zipCode,
                                  hintText: AppLocalizations.of(context)!.zipCode,
                                  keyboardType: TextInputType.phone,
                                  isReadOnly: true,
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
                                  isReadOnly: true,
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

                              _.urlImage == "" || _.urlImage.isEmpty
                                  ? Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: const DecorationImage(
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
                                                    image: AssetImage(Images.person_png),
                                                    fit: BoxFit.cover),
                                              ),
                                            );
                                          },
                                          loadingBuilder: (BuildContext context, Widget child,
                                              ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              return Container(
                                                width: 120,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                                child: child,
                                              );
                                            }
                                            return SizedBox(
                                              width: 120,
                                              height: 120,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                          loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                              Dimensions.PADDING_SIZE_24.spaceY,
                              Dimensions.PADDING_SIZE_16.spaceY,
                              CustomInfoWidget(
                                heading: AppLocalizations.of(context)!.firstName,
                                hintText: "",
                                controller: _.txtFName,
                                isReadOnly: true,
                              ),
                              CustomInfoWidget(
                                heading: AppLocalizations.of(context)!.lastName,
                                hintText: "",
                                controller: _.txtLName,
                                isReadOnly: true,
                              ),
                              CustomInfoWidget(
                                heading: AppLocalizations.of(context)!.emailAddress,
                                hintText: "",
                                controller: _.txtEmail,
                                isReadOnly: true,
                              ),
                              CustomInfoWidget(
                                  heading: AppLocalizations.of(context)!.dateOfBirth,
                                  hintText: AppLocalizations.of(context)!.dateOfBirth,
                                  focusNode: _.focusNodeDob,
                                  isReadOnly: true,
                                  onTap: () {},
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
                              //           onTap: () {},
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
                              //               child: Text(
                              //                 _.formattedDate,
                              //                 style: FontSize.txtPop16_400,
                              //               ),
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
                                hintText: "",
                                controller: _.txtPhoneNumb,
                                isReadOnly: true,
                              ),
                              CustomInfoWidget(
                                heading: AppLocalizations.of(context)!.streetNHouse,
                                hintText: "",
                                controller: _.txtAddress,
                                isReadOnly: true,
                              ),
                              CustomInfoWidget(
                                heading: AppLocalizations.of(context)!.zipCode,
                                hintText: "",
                                controller: _.txtZipCode,
                                isReadOnly: true,
                              ),
                              CustomInfoWidget(
                                heading: AppLocalizations.of(context)!.city,
                                hintText: "",
                                controller: _.txtCity,
                                isReadOnly: true,
                              ),
                              Dimensions.PADDING_SIZE_16.spaceY,
                            ],
                          ),
                  ),
                ),
              ),
              // bottomNavigationBar: Container(
              //     margin: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_16),
              //     width: double.infinity,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             CustomButton(
              //               isLoader: _.isLoading,
              //               onTap: () {
              //                 _.setUserData();
              //               },
              //               text: "Save Profile",
              //               horizontal: 20,
              //             ),
              //           ],
              //         )
              //       ],
              //     )),
            ),
          );
        });
  }
}
