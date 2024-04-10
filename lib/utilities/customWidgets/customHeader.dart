import 'package:flutter/material.dart';

import '../colorconstant.dart';

Widget customHeader(Animation<Offset> offsetAnimation, String title) {
  return SlideTransition(
    position: offsetAnimation,
    child: Container(
      height: 100.0,
      decoration: BoxDecoration(
        color: AppColors.kPrimary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
