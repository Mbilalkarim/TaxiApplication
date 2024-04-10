import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/utilities/extensions.dart';

import '../../Controller/authController/auth_service.dart';
import '../../Controller/settingController.dart';
import '../../utilities/app_size.dart';
import '../../utilities/app_utilities.dart';
import '../../utilities/colorconstant.dart';
import '../../utilities/customWidgets/customAppBarr.dart';
import '../../utilities/customWidgets/inLineContent.dart';
import '../../utilities/debug.dart';
import '../../utilities/dimensions.dart';
import '../../utilities/fontsizes.dart';
import '../auth/loginView.dart';
import 'deleteAccountView.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
        init: SettingController(),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              titleStr: AppLocalizations.of(context)!.settings,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: Divider(
                  height: 10,
                  color: AppColors.kGrey.withOpacity(0.5),
                ),
              ),
            ),
            body: AbsorbPointer(
              absorbing: _.isLoader,
              child: Padding(
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_32),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSizes.appVerticalSm,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_16, bottom: Dimensions.PADDING_SIZE_5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.changeLanguage,
                            style: FontSize.txtPop16_500,
                          ),
                          PopupMenuButton<String>(
                            onSelected: (String result) {
                              if (result == "en") {
                                _.changeLanguage(const Locale("en"));
                              } else {
                                _.changeLanguage(const Locale("de"));
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'en',
                                child: Text(
                                  'English',
                                  style: FontSize.txtPop14_800,
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: "de",
                                child: Text(
                                  'German',
                                  style: FontSize.txtPop14_800,
                                ),
                              ),
                            ],
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_10),
                              child: Text(
                                _.languageCode == "en" ? "English" : "German",
                                style: FontSize.txtPop14_800.copyWith(color: AppColors.kPrimary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: AppColors.kGrey.withOpacity(0.5),
                      width: double.infinity,
                    ),
                    inLineContent(AppLocalizations.of(context)!.frequentlyAskedQuestions, () {},
                        style: FontSize.txtPop16_500),
                    inLineContent(AppLocalizations.of(context)!.termsOfUseNPrivacyPolicy, () {},
                        style: FontSize.txtPop16_500),
                    inLineContent(AppLocalizations.of(context)!.logout, () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: AppColors.kWhite,
                            surfaceTintColor: AppColors.kBlack.withOpacity(0.2),
                            title: Text(
                              'Logout Account',
                              style: FontSize.txtPop18_600.copyWith(color: AppColors.kRed),
                            ),
                            content: const Text(
                              'Are you sure you want to Logout from your account?',
                              style: FontSize.txtPop14_600,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // Cancel button action
                                },
                                child: const Text(
                                  'Cancel',
                                  style: FontSize.txtPop16_600,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    _.isLoader = true;

                                    await AuthService.firebase().logout();
                                    deleteLocalData();
                                    _.isLoader = false;

                                    Get.myOffAll(const LoginView());
                                  } catch (e) {
                                    _.update();
                                    debug(e);
                                  }
                                  // Delete button action
                                  // You can call a method here to delete the account
                                  // Example: deleteAccount();
                                },
                                child: Text(
                                  'Logout ',
                                  style: FontSize.txtPop16_600.copyWith(color: AppColors.kRed),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }, style: FontSize.txtPop16_500),
                    inLineContent(AppLocalizations.of(context)!.deleteAccount, () {
                      Get.myGetTo(const DeleteAccountView());
                    }, style: FontSize.txtPop16_500.copyWith(color: AppColors.kRed)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
