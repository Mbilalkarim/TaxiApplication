import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colorconstant.dart';
import '../dimensions.dart';
import '../fontsizes.dart';
import '../images.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T selectedValue;
  final ValueChanged<T?> onChanged;
  final FocusNode? focusNode;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.focusNode,
  });

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late T _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(border: Border.all(color: AppColors.kLightestGrey)),
      child: DropdownButton<T>(
        focusNode: widget.focusNode,
        padding: EdgeInsets.zero,
        itemHeight: 48,
        menuMaxHeight: 250,
        isExpanded: true,
        style: FontSize.txtPop14_600.copyWith(color: AppColors.kBlack),
        value: _dropdownValue,
        icon: Padding(
            padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_24),
            child: SvgPicture.asset(Images.dropDown_svg)),
        items: widget.items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
        underline: Container(),
        onChanged: (T? value) {
          setState(() {
            _dropdownValue = value!;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
