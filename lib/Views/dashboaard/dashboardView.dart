import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/utilities/customWidgets/customHeader.dart';
import 'package:taxiapplication/utilities/debug.dart';
import 'package:taxiapplication/utilities/dimensions.dart';
import 'package:taxiapplication/utilities/extensions.dart';

import '../../Controller/ProfileController.dart';
import '../../Controller/dashboardController.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colorconstant.dart';
import '../../utilities/customWidgets/inLineContent.dart';
import '../../utilities/fontsizes.dart';
import '../../utilities/images.dart';
import '../profile/ProfileView.dart';
import '../settings/settingsView.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (_) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    customHeader(_.offsetAnimation,
                        "Welcome ${_.userModel.firstName} ${_.userModel.lastName}"),
                    SizedBox(
                      height: AppSizes.appVerticalLg,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.taxiLogo_png,
                          height: AppSizes.appVerticalLg,
                          width: AppSizes.appVerticalLg,
                        ),
                      ],
                    ),
                    AppSizes.appVerticalSm.spaceY,
                    const Text(
                      "Taxi App",
                      style: FontSize.txtPop24_800,
                    ),
                    SizedBox(
                      height: AppSizes.appVerticalMd,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_32),
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: AppColors.kGrey.withOpacity(0.5),
                            width: double.infinity,
                          ),
                          inLineContent(AppLocalizations.of(context)!.profile, () async {
                            Get.put(ProfileController());
                            debug(_.userModel.userType);
                            Get.find<ProfileController>().isSettings = true;
                            Get.find<ProfileController>().selectedValue =
                                _.userModel.userType.toString();

                            Get.find<ProfileController>().getUserData();
                            Get.myGetTo(const ProfileView());
                          }),
                          inLineContent(AppLocalizations.of(context)!.settings, () {
                            Get.myGetTo(const SettingsView());
                          }),
                        ],
                      ),
                    ),
                    // _.xFile.isEmpty || _.xFile == []
                    //     ? Stack(
                    //         alignment: Alignment.center,
                    //         children: [
                    //           Image.asset(
                    //             Images.qrImage_png,
                    //             width: 250,
                    //             height: AppSizes.appVerticalXXL * 1.4,
                    //             fit: BoxFit.cover,
                    //           ),
                    //           Container(
                    //             color: AppColors.kWhite.withOpacity(0.7),
                    //             width: 250,
                    //             height: AppSizes.appVerticalXXL * 1.4,
                    //           ),
                    //           Container(
                    //               color: AppColors.kWhite.withOpacity(0.7),
                    //               width: double.infinity,
                    //               height: AppSizes.appVerticalXXL * 2,
                    //               alignment: Alignment.center,
                    //               child: InkWell(
                    //                 onTap: () async {
                    //                   await _.generateQRCode();
                    //                 },
                    //                 child: Material(
                    //                   borderRadius: BorderRadius.circular(12),
                    //                   elevation: 7,
                    //                   child: _.isLoading
                    //                       ? const SizedBox(
                    //                           height: 30,
                    //                           width: 30,
                    //                           child: CircularProgressIndicator(
                    //                             color: AppColors.kBlue,
                    //                           ),
                    //                         )
                    //                       : Container(
                    //                           decoration: BoxDecoration(
                    //                               borderRadius: BorderRadius.circular(12)),
                    //                           margin: const EdgeInsets.symmetric(
                    //                               vertical: Dimensions.PADDING_SIZE_8,
                    //                               horizontal: Dimensions.PADDING_SIZE_24),
                    //                           child: Text(
                    //                             AppLocalizations.of(context)!.generateQrCode,
                    //                             style: FontSize.txtPop18_800
                    //                                 .copyWith(color: AppColors.kPrimary),
                    //                           ),
                    //                         ),
                    //                 ),
                    //               )),
                    //         ],
                    //       )
                    //     : Column(
                    //         children: [
                    //           Container(
                    //             margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_32),
                    //             padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_5),
                    //             decoration: BoxDecoration(
                    //                 color: AppColors.kBlack,
                    //                 border: Border.all(color: AppColors.kGrey.withOpacity(0.2))),
                    //             width: 250,
                    //             height: AppSizes.appVerticalXXL * 1.5,
                    //             child: Image.file(
                    //               File(_.xFile.first.path),
                    //               fit: BoxFit.fill,
                    //             ),
                    //           ),
                    //           Dimensions.PADDING_SIZE_16.spaceY,
                    //         ],
                    //       ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
