import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/utilities/customWidgets/customHeader.dart';

import '../../Controller/authController/controller/loginController.dart';
import '../../Controller/authController/controller/verifyOtpController.dart';
import '../../utilities/StringConstant.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colorconstant.dart';
import '../../utilities/customWidgets/SingleTextField.dart';
import '../../utilities/dimensions.dart';
import '../../utilities/fontsizes.dart';
import '../../utilities/images.dart';
import 'loginView.dart';

class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyOtpController>(
        init: VerifyOtpController(),
        builder: (_) {
          return AbsorbPointer(
            absorbing: _.isLoading,
            child: PopScope(
              canPop: false,
              onPopInvoked: (didPop) {
                if (didPop) {
                  _.timer.cancel();
                }
              },
              child: Scaffold(
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        customHeader(_.offsetAnimation, "Taxi App Otp"),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_16),
                          child: Column(
                            children: [
                              SizedBox(
                                height: AppSizes.appVerticalMd,
                              ),
                              Hero(
                                tag: HeroConstant.HERO_LOGIN_BTN,
                                child: Material(
                                  child: Text(
                                    AppLocalizations.of(context)!.verifyYourPhoneNumber,
                                    style: FontSize.txtPop16_800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: AppSizes.appVerticalSm,
                              ),
                              Text(
                                AppLocalizations.of(context)!.verifyPhoneDesc,
                                style: FontSize.txtPop14_400,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: AppSizes.appVerticalMd,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  6,
                                  (index) => SingleTextField(
                                      focusNode: _.focusNodes[index],
                                      controller: _.textControllers[index],
                                      maxLength: _.textControllers[index].text.isEmpty ? 6 : 1,
                                      style: FontSize.txtPop14_600
                                          .copyWith(height: 24 / 20, color: AppColors.kPrimary),
                                      onChanged: (value) async {
                                        if (value.length == 1 ||
                                            (value.length == 6 && int.tryParse(value) != null)) {
                                          // If the entered value is exactly 6 digits, distribute them across the text fields
                                          if (value.length == 6) {
                                            for (int i = 0; i < value.length; i++) {
                                              if (i < _.textControllers.length) {
                                                _.textControllers[i].text = value[i];
                                              }
                                            }
                                          }
                                        }
                                        if (!_.isAnyEmpty()) {
                                          if (_.isDelete) {
                                            await _.deleteUser(context);
                                          } else {
                                            await _.verifyOtp();
                                          }
                                        }

                                        if (value.isEmpty && index > 0) {
                                          FocusScope.of(context)
                                              .requestFocus(_.focusNodes[index - 1]);
                                        } else if (index == 5 && value.length == 1) {
                                          FocusScope.of(context).unfocus();
                                        } else if (value.length == 1) {
                                          FocusScope.of(context)
                                              .requestFocus(_.focusNodes[index + 1]);
                                          _.update();
                                        }
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: AppSizes.appVerticalSm,
                              ),
                              Text(
                                AppLocalizations.of(context)!.enterSixDigitCode,
                                style: FontSize.txtPop14_500
                                    .copyWith(color: AppColors.kSilver.withOpacity(0.8)),
                              ),
                              SizedBox(
                                height: AppSizes.appVerticalMd,
                              ),
                              if (!_.isDelete)
                                Column(
                                  children: [
                                    Hero(
                                      tag: HeroConstant.HERO_WRONG_NO,
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {
                                            // Get.myGetTo(const LoginView());
                                            // _.timer.cancel();
                                            // _.oldNumber.add(_.txtPhoneNumb.text);
                                            Get.offAll(const LoginView());
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.mobile_screen_share_outlined),
                                              Dimensions.PADDING_SIZE_8.spaceX,
                                              Text(
                                                AppLocalizations.of(context)!.wrongNumber,
                                                style: FontSize.txtPop14_600.copyWith(
                                                    color: _.isTimeShow == null || _.isTimeShow!
                                                        ? AppColors.kGrey.withOpacity(0.5)
                                                        : AppColors.kBlack),
                                              ),
                                              Dimensions.PADDING_SIZE_8.spaceY,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Dimensions.PADDING_SIZE_10.spaceY,
                                    Row(
                                      children: [
                                        Container(
                                          width: 30,
                                        ),
                                        Expanded(
                                          child: Divider(
                                            height: 10,
                                            color: AppColors.kGrey.withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Dimensions.PADDING_SIZE_10.spaceY,
                                    InkWell(
                                      onTap: () {
                                        if (_.isTimeShow == null || _.isTimeShow!) {
                                          return;
                                        }
                                        Get.put(LoginController());
                                        Get.find<LoginController>().createUserOtp(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(Images.resendSms_svg),
                                          Dimensions.PADDING_SIZE_8.spaceX,
                                          Column(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.resendSms,
                                                style: FontSize.txtPop14_600.copyWith(
                                                    color: _.isTimeShow == null || _.isTimeShow!
                                                        ? AppColors.kGrey.withOpacity(0.5)
                                                        : AppColors.kBlack),
                                              ),
                                            ],
                                          ),
                                          Dimensions.PADDING_SIZE_5.spaceX,
                                          if (_.isTimeShow == null || _.isTimeShow!)
                                            Text(
                                              '${_.remainingMinutes}:${_.remainingSeconds < 10 ? '0${_.remainingSeconds}' : _.remainingSeconds}',
                                              style: FontSize.txtPop14_400.copyWith(
                                                  color: _.isTimeShow == null || _.isTimeShow!
                                                      ? AppColors.kGrey.withOpacity(0.5)
                                                      : AppColors.kBlack),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
