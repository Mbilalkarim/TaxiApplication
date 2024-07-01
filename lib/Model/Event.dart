import 'dart:convert';

import 'package:uuid/uuid.dart';

class EventModel {
  String? id;
  String? name;
  DateTime? date;
  List<ActivityModel>? activities;

  EventModel({this.name, this.date, String? id, this.activities}) : id = id ?? Uuid().v1();

  @override
  String toString() {
    return 'Event{id: $id, name: $name, date: $date, activities: $activities}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date?.toIso8601String(),
      'activities': activities?.map((activity) => activity.toMap()).toList(),
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  static EventModel fromJson(String jsonString) {
    Map<String, dynamic> map = json.decode(jsonString);
    return EventModel(
      id: map['id'],
      name: map['name'],
      date: DateTime.tryParse(map['date']),
      activities: (map['activities'] as List<dynamic>?)
          ?.map((activity) => ActivityModel.fromMap(activity))
          .toList(),
    );
  }
}

class ActivityModel {
  String? name;

  ActivityModel({this.name});

  @override
  String toString() {
    return 'Activity{name: $name}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      name: json['name'],
    );
  }

  // Serialize ActivityModel object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
    };
    return data;
  }

  static ActivityModel fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      name: map['name'],
    );
  }
}
