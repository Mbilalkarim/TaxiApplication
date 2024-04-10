import 'package:flutter/material.dart';

import '../app_size.dart';
import '../colorconstant.dart';
import '../dimensions.dart';
import '../get_permissions.dart';

Future<String> customDialog(
  BuildContext context,
) async {
  String select = "";
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalXL),
          // contentPadding:EdgeInsets.symmetric(horizontal: 20),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_8 + 2))),
          title: const Center(child: Text('Add Image')),
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_16),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    "Here’s some alert text. It can span multiple lines if needed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "SF Pro Text", fontSize: 13, fontWeight: FontWeight.w400),
                  )),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: AppColors.kSilver,
            ),
            Center(
              child: SimpleDialogOption(
                onPressed: () async {
                  bool permissionGranted = await MyPermissionHandler.checkPermission(context,
                      permissionName: 'camera'); // e.g.
                  if (permissionGranted) {
                    select = "camera";
                  }
                  Navigator.pop(context);
                },
                child: const Text('Take Photo',
                    style: TextStyle(
                        fontFamily: "SF Pro Text",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 122, 255, 1))),
              ),
            ),
            const Divider(
              thickness: 1,
              color: AppColors.kSilver,
            ),
            Center(
              child: SimpleDialogOption(
                onPressed: () async {
                  bool permissionGranted = await MyPermissionHandler.checkPermission(context,
                      permissionName: 'gallery'); // e.g.
                  if (permissionGranted) {
                    select = "gallery";
                  }
                  Navigator.pop(context);
                },
                child: const Text('Upload Image',
                    style: TextStyle(
                        fontFamily: "SF Pro Text",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 122, 255, 1))),
              ),
            ),
            const Divider(
              thickness: 1,
              color: AppColors.kSilver,
            ),
            Center(
              child: SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel',
                    style: TextStyle(
                        fontFamily: "SF Pro Text",
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(220, 42, 42, 1))),
              ),
            ),
          ],
        );
      });
  return select;
}
