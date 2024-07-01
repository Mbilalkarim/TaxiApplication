import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../Controller/authController/auth_service.dart';
import '../../Controller/authController/controller/loginController.dart';
import '../../utilities/app_size.dart';
import '../../utilities/app_utilities.dart';
import '../../utilities/colorconstant.dart';
import '../../utilities/customWidgets/customAppBarr.dart';
import '../../utilities/customWidgets/customButtom.dart';
import '../../utilities/debug.dart';
import '../../utilities/dimensions.dart';
import '../../utilities/fontsizes.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              titleStr: AppLocalizations.of(context)!.deleteAccount,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: Divider(
                  height: 10,
                  color: AppColors.kGrey.withOpacity(0.5),
                ),
              ),
            ),
            body: PopScope(
              canPop: !_.isLoader,
              child: AbsorbPointer(
                absorbing: _.isLoader,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_24),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSizes.appVerticalSm,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            right: Dimensions.PADDING_SIZE_16, left: Dimensions.PADDING_SIZE_16),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.deleteAccountDesc,
                              style: FontSize.txtPop16_500,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: AppSizes.appVerticalSm,
                            ),
                            Text(
                              AppLocalizations.of(context)!.pleaseEnterYourPasswordToContinue,
                              style: FontSize.txtPop16_500,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: AppSizes.appVerticalMd,
                            ),
                          ],
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       AppLocalizations.of(context)!.currentPassword,
                      //       style: FontSize.txtPop14_600,
                      //     ),
                      //     CustomTextField(
                      //       hintText: AppLocalizations.of(context)!.enterCurrentPassword,
                      //       autoCorrect: false,
                      //       style: FontSize.txtPop14_500,
                      //       obscureText: _.boPass,
                      //       isPass: true,
                      //       suffix: InkWell(
                      //         onTap: () {
                      //           _.boPass = !_.boPass;
                      //           _.update();
                      //           // _.passwordObscure(_.boPass);
                      //         },
                      //         child: Column(
                      //           children: [
                      //             Icon(_.boPass ? Icons.remove_red_eye_outlined : Icons.remove_red_eye)
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: AppSizes.appVerticalMd,
                      ),
                      Container(
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
                                    isLoader: _.isLoader,
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            surfaceTintColor: AppColors.kBlack.withOpacity(0.2),
                                            title: Text(
                                              'Delete Account',
                                              style: FontSize.txtPop18_600
                                                  .copyWith(color: AppColors.kRed),
                                            ),
                                            content: const Text(
                                              'Are you sure you want to delete your account? This action cannot be undone and you will need to re-verify your account.',
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
                                                    if (AuthService.firebase()
                                                            .currentUser
                                                            ?.providerId ==
                                                        'phone') {
                                                    } else {
                                                      customSnackBar(
                                                          context,
                                                          AppColors.kRed,
                                                          AppColors.kWhite,
                                                          "Un-expected Error Occurred");
                                                    }
                                                  } catch (e) {
                                                    _.isLoader = false;
                                                    _.update();
                                                    debug(e);
                                                  }
                                                  // Delete button action
                                                  // You can call a method here to delete the account
                                                  // Example: deleteAccount();
                                                },
                                                child: Text(
                                                  'Delete Account',
                                                  style: FontSize.txtPop16_600
                                                      .copyWith(color: AppColors.kRed),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    bgColor: AppColors.kRed,
                                    borderColor: AppColors.kRed,
                                    text: AppLocalizations.of(context)!.deleteAccount,
                                    horizontal: 50,
                                  ),
                                ],
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
