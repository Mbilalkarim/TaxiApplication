import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MyPermissionHandler {
  static Future<bool> checkPermission(
    BuildContext context, {
    String permissionName = 'gallery',
  }) async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      if (sdkInt < 33 && permissionName == 'gallery') {
        // if (permissionName == 'gallery') {
        Map<Permission, PermissionStatus> statues;
        statues = await [
          Permission.storage,
        ].request();
        PermissionStatus? statusPhotos = statues[Permission.storage];
        if (statusPhotos == PermissionStatus.granted) {
          return true;
        } else if (statusPhotos == PermissionStatus.permanentlyDenied) {
          // showPermissionDialog (context, permissionName);
          return false;
        } else if (statusPhotos == PermissionStatus.limited) {
          // showLimitedPermissionDialog (context, permissionName);
          return false;
        } else {
          return false;
        }
      }
    }
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues;
    switch (permissionName) {
      case 'camera':
        {
          statues = await [Permission.camera].request();
          PermissionStatus? statusCamera = statues[Permission.camera];
          if (statusCamera == PermissionStatus.granted) {
            return true;
          } else if (statusCamera == PermissionStatus.permanentlyDenied) {
            // showPermissionDialog (context, permissionName);
            return false;
          } else {
            return false;
          }
        }
      case 'gallery':
        {
          statues = await [
            Permission.photos,
          ].request();
          PermissionStatus? statusPhotos = statues[Permission.photos];
          if (statusPhotos == PermissionStatus.granted) {
            return true;
          } else if (statusPhotos == PermissionStatus.permanentlyDenied) {
            // showPermissionDialog (context, permissionName);
            return false;
          } else if (statusPhotos == PermissionStatus.limited) {
            // showLimitedPermissionDialog (context, permissionName);
            return false;
          } else {
            return false;
          }
        }
    }
    return false;
  }
}
