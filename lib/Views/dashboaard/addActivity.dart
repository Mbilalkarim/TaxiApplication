import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/Controller/authController/addActivityController.dart';
import 'package:taxiapplication/Model/Event.dart';
import 'package:taxiapplication/utilities/colorconstant.dart';
import 'package:taxiapplication/utilities/customWidgets/customButtom.dart';
import 'package:taxiapplication/utilities/customWidgets/customHeader.dart';
import 'package:taxiapplication/utilities/customWidgets/customTextfield.dart';
import 'package:taxiapplication/utilities/dimensions.dart';
import 'package:taxiapplication/utilities/fontsizes.dart';

import '../../Controller/dashboardController.dart';

class AddActivityView extends StatelessWidget {
  const AddActivityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivityController>(
        init: ActivityController(),
        builder: (_) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: PopScope(
              canPop: true,
              onPopInvoked: (didPop) {
                Get.put(DashboardController());
                Get.find<DashboardController>().loadEvents();
              },
              child: Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    customHeader(_.offsetAnimation, "Add Activity"),
                    Dimensions.PADDING_SIZE_24.spaceY,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Event Id",
                                style: FontSize.txtPop18_800,
                              ),
                              Text(
                                _.eventId,
                                style: FontSize.txtPop16_600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Event Name",
                                style: FontSize.txtPop18_800,
                              ),
                              Text(
                                _.eventName,
                                style: FontSize.txtPop16_600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Dimensions.PADDING_SIZE_24.spaceY,
                    Text(
                      "Enter Activity Name",
                      style: FontSize.txtPop16_800.copyWith(color: AppColors.kPrimary),
                    ),
                    CustomTextField(
                      controller: _.activityController,
                      hintText: "Add Activity Name",
                    ),
                    Dimensions.PADDING_SIZE_24.spaceY,
                    Row(
                      children: [
                        Flexible(
                            child: CustomButton(
                          onTap: () {
                            if (_.activityController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Please add an activity name"),
                                backgroundColor: AppColors.kRed,
                              ));
                              return;
                            }
                            _.allActivities.add(ActivityModel(name: _.activityController.text));
                            _.addActivityToEvent(_.activityController.text);
                            _.activityController.clear();

                            _.update();
                          },
                          text: "Add Activity",
                          style: FontSize.txtPop18_800,
                        )),
                      ],
                    ),
                    _.allActivities == [] || _.allActivities.isEmpty
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.PADDING_SIZE_24,
                                      vertical: Dimensions.PADDING_SIZE_24),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.kRed),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "No activities available, please add some to view them",
                                        textAlign: TextAlign.center,
                                        style:
                                            FontSize.txtPop16_600.copyWith(color: AppColors.kRed),
                                      ),
                                      Dimensions.PADDING_SIZE_24.spaceY,
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                            itemCount: _.allActivities.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_10),
                                child: Text(_.allActivities[index].name ?? ""),
                              );
                            },
                          )),
                    // Add fields to input activity details
                  ],
                ),
              ),
            ),
          );
        });
  }
}
