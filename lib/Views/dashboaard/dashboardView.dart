import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/Controller/authController/addActivityController.dart';
import 'package:taxiapplication/Views/dashboaard/addActivity.dart';
import 'package:taxiapplication/utilities/colorconstant.dart';
import 'package:taxiapplication/utilities/customWidgets/customButtom.dart';
import 'package:taxiapplication/utilities/dimensions.dart';
import 'package:taxiapplication/utilities/extensions.dart';
import 'package:taxiapplication/utilities/fontsizes.dart';

import '../../Controller/dashboardController.dart';
import '../../utilities/customWidgets/customHeader.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (_) {
          return Scaffold(
            floatingActionButton: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => _.dialog(context),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.kPrimary),
                child: const Icon(
                  Icons.add,
                  size: 24,
                  color: AppColors.kWhite,
                ),
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customHeader(_.offsetAnimation, "Dashboard"),
                    Dimensions.PADDING_SIZE_24.spaceY,
                    const Text(
                      "Event List",
                      style: FontSize.txtPop18_800,
                    ),
                    Divider(
                      height: 10,
                      color: AppColors.kPrimary.withOpacity(0.5),
                    ),
                    if (_.events != [] || _.events.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_5),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(flex: 5, child: Text("Name")),
                            Flexible(flex: 2, child: Text("Date")),
                            Flexible(flex: 2, child: Text("Activities#")),
                            Flexible(flex: 1, child: Text("")),
                          ],
                        ),
                      ),
                    _.events == [] || _.events.isEmpty
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.PADDING_SIZE_24,
                                      vertical: Dimensions.PADDING_SIZE_24),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.kRed),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    children: [
                                      Text("Please click here to add an event",
                                          textAlign: TextAlign.center,
                                          style: FontSize.txtPop16_600
                                              .copyWith(color: AppColors.kRed)),
                                      Dimensions.PADDING_SIZE_24.spaceY,
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                              child: CustomButton(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) => _.dialog(context),
                                                    );
                                                  },
                                                  text: "Add Event")),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _.events.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: Dimensions.PADDING_SIZE_10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: AppColors.kPrimary.withOpacity(0.5))),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      var cont = Get.put(ActivityController());
                                      cont.events = _.events;
                                      cont.allActivities = _.events[index].activities ?? [];
                                      cont.eventId = _.events[index].id ?? "";
                                      cont.eventName = _.events[index].name ?? "";
                                      Get.myGetTo(const AddActivityView());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: Dimensions.PADDING_SIZE_4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                              flex: 4, child: Text(_.events[index].name ?? "")),
                                          Flexible(
                                            flex: 2,
                                            child: Text(
                                                '${_.events[index].date?.day}, ${_.events[index].date?.month}  ${_.events[index].date?.year}'),
                                          ),
                                          Flexible(
                                              flex: 2,
                                              child: Text(
                                                  "${_.events[index].activities?.length ?? 0}")),
                                          Flexible(
                                            flex: 2,
                                            child: IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                // Delete the event
                                                _.deleteEvent(_.events[index]);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // child: ListTile(
                                  //   title: Text(_.events[index].name ?? ""),
                                  //   subtitle: Text('${_.events[index].date}'),
                                  //   trailing: IconButton(
                                  //     icon: Icon(Icons.delete),
                                  //     onPressed: () {
                                  //       // Delete the event
                                  //       _.deleteEvent(_.events[index]);
                                  //     },
                                  //   ),
                                  // ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
