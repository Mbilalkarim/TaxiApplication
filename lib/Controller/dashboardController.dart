import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiapplication/Model/Event.dart';
import 'package:taxiapplication/utilities/colorconstant.dart';
import 'package:taxiapplication/utilities/getStorage.dart';

import 'localNotification.dart';

class DashboardController extends GetxController with GetTickerProviderStateMixin {
  List<EventModel> events = [];
  TextEditingController nameController = TextEditingController();
  DateTime? selectedDate;
  List<ActivityModel> allActivities = [];

  void loadEvents() async {
    events = await readEvents();
    update();
  }

  void addEvent(EventModel event) {
    events.add(event);
    storeEvents(events);
    loadEvents();

    // Save events to local storage
    // Implement your storage logic here
  }

  void deleteEvent(EventModel event) {
    events.remove(event);
    storeEvents(events);
    loadEvents();
  }

  late AnimationController controller;
  late Animation<Offset> offsetAnimation;
  @override
  void onInit() {
    loadEvents();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0), // Starting position above the screen
      end: Offset.zero, // Ending position at the top of the screen
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn, // Simulating a drop-down motion
    ));

    // Start the animation
    Future.delayed(
      const Duration(seconds: 1),
      () {
        controller.forward();
      },
    );
    super.onInit();
  }

  AlertDialog dialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Event'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Event Name'),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              // Show date picker
              showDatePicker(
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 1)),
                firstDate: DateTime.now().add(const Duration(days: 1)),
                lastDate: DateTime(2100),
              ).then((pickedDate) {
                if (pickedDate != null) {
                  selectedDate = pickedDate;
                  update();
                }
              });
            },
            child: Row(
              children: [
                Text(
                  selectedDate == null
                      ? 'Select Date'
                      : 'Selected Date:   ${selectedDate!.toString().substring(0, 10)}   ',
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Close the dialog box
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isEmpty || selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please add all the fields"),
                  backgroundColor: AppColors.kRed,
                ),
              );
              return;
            }
            LocalNotificationService().showNotificationAndroid(
                "Event Successfully Created", "Event Name: ${nameController.text}");

            final newEvent = EventModel(
              name: nameController.text,
              date: selectedDate,
            );
            addEvent(newEvent);
            selectedDate = null;
            nameController.clear();
            // Do something with new event, e.g., save to storage
            // Close the dialog box
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
