import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:taxiapplication/Model/Event.dart';

import 'AppConstants.dart';
import 'debug.dart';

final box = GetStorage();

bool checkHaData(String id) {
  try {
    return box.hasData(id);
  } catch (e) {
    debug(e);
    return false;
  }
}

Future<void> storeVerificationId(String id) async {
  try {
    await box.write(AppConstants.VERIFICATION_ID, id);
  } catch (e) {
    debug(e);
  }
}

Future<void> deleteVerificationId() async {
  try {
    if (checkHaData(AppConstants.VERIFICATION_ID)) {
      await box.remove(AppConstants.VERIFICATION_ID);
    }
  } catch (e) {
    debug(e);
  }
}

Future<String> readVerificationId() async {
  try {
    if (checkHaData(AppConstants.VERIFICATION_ID)) {
      return await box.read(AppConstants.VERIFICATION_ID);
    } else {
      return "";
    }
  } catch (e) {
    debug(e);
    return "";
  }
}

Future<void> storeLanguage(String id) async {
  try {
    await box.write(AppConstants.LANGUAGE_CODE, id);
  } catch (e) {
    debug(e);
  }
}

Future<void> deleteLanguage() async {
  try {
    if (checkHaData(AppConstants.LANGUAGE_CODE)) {
      await box.remove(AppConstants.LANGUAGE_CODE);
    }
  } catch (e) {
    debug(e);
  }
}

Future<String> readLanguage() async {
  try {
    if (checkHaData(AppConstants.LANGUAGE_CODE)) {
      return await box.read(AppConstants.LANGUAGE_CODE);
    } else {
      return "en";
    }
  } catch (e) {
    debug(e);
    return "en";
  }
}

Future<void> storeEvents(List<EventModel> events) async {
  try {
    final eventsJson = events.map((event) => event.toJson()).toList();
    final data = jsonEncode(eventsJson);
    await box.write(AppConstants.USER_DATA, data);
  } catch (e) {
    debug(e.toString());
  }
}

Future<void> deleteEvent() async {
  try {
    if (box.hasData(AppConstants.USER_DATA)) {
      await box.remove(AppConstants.USER_DATA);
    }
  } catch (e) {
    debug(e.toString());
  }
}

Future<List<EventModel>> readEvents() async {
  try {
    if (box.hasData(AppConstants.USER_DATA)) {
      final userData = await box.read(AppConstants.USER_DATA);
      final List<dynamic> eventsList = jsonDecode(userData);
      final List<EventModel> eventModels =
          eventsList.map((eventJson) => EventModel.fromJson(eventJson)).toList();
      return eventModels;
    } else {
      return [];
    }
  } catch (e) {
    debug(e.toString());
    return [];
  }
}
