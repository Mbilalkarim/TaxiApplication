import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/utilities/customWidgets/customHeader.dart';

import '../../Controller/authController/controller/loginController.dart';
import '../../utilities/StringConstant.dart';
import '../../utilities/app_size.dart';
import '../../utilities/app_utilities.dart';
import '../../utilities/colorconstant.dart';
import '../../utilities/customWidgets/customButtom.dart';
import '../../utilities/customWidgets/customTextfield.dart';
import '../../utilities/dimensions.dart';
import '../../utilities/fontsizes.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (_) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: PopScope(
              canPop: true,
              onPopInvoked: (didPop) {},
              child: Container(
                height: AppSizes.screenHeight,
                color: AppColors.kWhite,
                child: SafeArea(
                  child: Column(
                    children: [
                      customHeader(_.offsetAnimation, "Taxi App Login"),
                      Expanded(
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppSizes.appVerticalMd.spaceY,
                              const Text(
                                "Enter Your Phone Number",
                                style: FontSize.txtPop24_800,
                              ),
                              Text(
                                "Enter your phone number to login to the application",
                                style: FontSize.txtPop14_400
                                    .copyWith(color: AppColors.kGrey.withOpacity(0.5)),
                              ),
                              SizedBox(
                                height: AppSizes.appVerticalMd,
                              ),
                              CountryCodePicker(
                                onChanged: (onSelect) {
                                  _.countryName = onSelect.name!;
                                  _.txtPhoneCode.text = onSelect.dialCode!;
                                  _.update();
                                },
                                builder: (p0) {
                                  // _.countryCode = p0!.dialCode.toString();
                                  _.txtPhoneCode.text = p0!.dialCode.toString();
                                  _.countryName = p0.name.toString();
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Dimensions.PADDING_SIZE_12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: AppColors.kPrimary)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              p0.name.toString(),
                                              style: FontSize.txtPop16_600,
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down_circle,
                                          color: AppColors.kSilver,
                                        ),
                                        Dimensions.PADDING_SIZE_24.spaceX,
                                      ],
                                    ),
                                  );
                                },
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'PK',
                                showDropDownButton: true,
                                showFlagDialog: true,
                                showFlag: true,
                                comparator: (a, b) => b.name!.compareTo(a.name!),

                                //Get the country information relevant to the initial selection
                                onInit: (code) =>
                                    print("on init ${code?.name} ${code?.dialCode} ${code?.name}"),
                              ),
                              SizedBox(
                                height: AppSizes.appVerticalSm,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomTextField(
                                          controller: _.txtPhoneCode,
                                          style: FontSize.txtPop16_600,
                                          vertical: 8,
                                          readOnly: true,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          ],
                                        ),
                                        // Text(
                                        //   _.countryCode,
                                        //   style: FontSize.txtPop16_600,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Dimensions.PADDING_SIZE_10.spaceX,
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomTextField(
                                          focusNode: _.phoneFocus,
                                          controller: _.txtPhoneNumb,
                                          style: FontSize.txtPop16_600,
                                          vertical: 8,
                                          hintText: AppLocalizations.of(context)!.enterPhoneNumber,
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppSizes.appVerticalLg,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    color: AppColors.kWhite,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Hero(
                                          tag: HeroConstant.HERO_LOGIN_BTN,
                                          child: Material(
                                            surfaceTintColor: AppColors.kTransparent,
                                            color: AppColors.kTransparent,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                CustomButton(
                                                    onTap: () {
                                                      if (_.txtPhoneNumb.text.trim().isNotEmpty) {
                                                        _.createUserOtp(context);
                                                      } else {
                                                        customSnackBar(
                                                            context,
                                                            AppColors.kRed,
                                                            AppColors.kWhite,
                                                            "Please input number");
                                                      }
                                                    },
                                                    style: FontSize.txtPop16_800,
                                                    isLoader: _.isLoader,
                                                    vertical: 12,
                                                    horizontal: AppSizes.appHorizontalXXL * 1.5,
                                                    radiusValue: 4,
                                                    text: AppLocalizations.of(context)!.next),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: AppSizes.appVerticalSm,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppSizes.appVerticalMd,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
