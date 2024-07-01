import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/utilities/debug.dart';
import 'package:taxiapplication/utilities/getStorage.dart';

import '../../Model/Event.dart';

class ActivityController extends GetxController with GetTickerProviderStateMixin {
  String eventId = "";
  String eventName = "";
  List<EventModel> events = [];
  TextEditingController activityController = TextEditingController();
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;
  List<ActivityModel> allActivities = [];
  @override
  void onInit() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1.0), // Starting position above the screen
      end: Offset.zero, // Ending position at the top of the screen
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn, // Simulating a drop-down motion
    ));

    // Start the animation
    Future.delayed(
      Duration(seconds: 1),
      () {
        controller.forward();
        extractActivitiesFromEvents();
      },
    );
    super.onInit();
  }

  @override
  void onClose() {
    allActivities = [];
    activityController.clear();
    events = [];

    super.onClose();
  }

  Future<void> addActivityToEvent(String name) async {
    try {
      debug(events);

      // Find the event by ID
      final index = events.indexWhere((event) => event.id == eventId);
      if (index >= 0) {
        debug("weare here2");
        events[index].activities = allActivities;
        debug(events);
        await storeEvents(events);
        events = await readEvents();
        allActivities = events[index].activities ?? [];
      } else {
        debugPrint('Event with ID $eventId not found.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void extractActivitiesFromEvents() {
    try {
      for (var event in events) {
        if (event.activities != null) {
          allActivities = event.activities ?? [];
        }
      }
    } catch (e) {
      debug(e.toString());
    }
  }
}
