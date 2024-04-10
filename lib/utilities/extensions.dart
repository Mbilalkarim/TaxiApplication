import 'package:flutter/material.dart';
import 'package:get/get.dart';

// extension MyExtensions on GetInterface {
//   Future<T?>? myGetTo<T>(Route route) {
//     return Get.to<T>(route,
//         transition: Transition.rightToLeft,
//         curve: Curves.easeInOut,
//         duration: const Duration(milliseconds: 500));
//   }
// }

extension MyExtensions on GetInterface {
  Future<T?>? myGetTo<T>(Widget screen,
      {Curve? curve, Duration? duration, bool? opaque, int? id, bool? preventDuplicates}) {
    return Get.to<T>(
      screen,
      curve: curve ?? Curves.fastOutSlowIn, // Use smoothest curve here
      duration: duration ?? const Duration(milliseconds: 1000),
      opaque: opaque ?? true,
      popGesture: true,
      fullscreenDialog: false,
      id: id,
      preventDuplicates: preventDuplicates ?? false,
    );
  }
}

extension MyExtensions2 on GetInterface {
  Future<T?>? myOffAll<T>(Widget screen,
      {Curve? curve,
      Transition? transition,
      Duration? duration,
      bool? opaque,
      int? id,
      bool? preventDuplicates}) {
    return Get.offAll<T>(
      screen,
      transition: transition ?? Transition.rightToLeft,
      curve: curve ?? Curves.fastOutSlowIn, // Use smoothest curve here
      duration: duration ?? const Duration(milliseconds: 1000),
      opaque: opaque ?? true,
      id: id,
    );
  }
}
