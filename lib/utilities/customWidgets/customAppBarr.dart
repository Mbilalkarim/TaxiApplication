import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colorconstant.dart';
import '../fontsizes.dart';
import '../images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleStr;
  final bool isBack;
  final bool isCenterTittle;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final PreferredSizeWidget? bottom;
  final Color backgroundColor;
  const CustomAppBar(
      {super.key,
      Key? key1,
      required this.titleStr,
      this.isBack = true,
      this.actions,
      this.isCenterTittle = true,
      this.onBack,
      this.bottom,
      this.backgroundColor = AppColors.kWhite});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      centerTitle: isCenterTittle,
      elevation: 0,
      titleSpacing: 0,
      leading: isBack
          ? IconButton(
              splashRadius: 25,
              onPressed: onBack ??
                  () {
                    Navigator.pop(context);
                  },
              icon: SvgPicture.asset(Images.backArrow_svg))
          : null,
      title: Text(
        titleStr,
        style: FontSize.txtPop16_800.copyWith(color: AppColors.kBlack),
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
