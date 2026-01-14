import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_time_picker_text.dart';

class CustomCupertinoPicker extends StatelessWidget {
  const CustomCupertinoPicker.hours({
    super.key,
    required this.onSelect,
    this.controller,
    this.selectedBgColor,
  }) : type = PickerType.hours;

  const CustomCupertinoPicker.minutes({
    super.key,
    required this.onSelect,
    this.controller,
    this.selectedBgColor,
  }) : type = PickerType.minutes;

  const CustomCupertinoPicker.amOrPm({
    super.key,
    required this.onSelect,
    this.controller,
    this.selectedBgColor,
  }) : type = PickerType.amOrPm;

  final PickerType type;
  final Function(int value)? onSelect;
  final FixedExtentScrollController? controller;
  final Color? selectedBgColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      itemExtent: 30,
      diameterRatio: 0.9,
      magnification: 1.2,
      useMagnifier: true,
      scrollController: controller,
      onSelectedItemChanged: (value) {
        if(type == PickerType.hours) {
          onSelect!(int.parse((value+1).toString().padLeft(2, '0')));
        } else {
          onSelect!(int.parse(value.toString().padLeft(2, '0')));
        }
      },
      selectionOverlay: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: selectedBgColor?? Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: type != PickerType.amOrPm
            ? customTimePickerText(
                type == PickerType.hours ? 'hour' : 'min',
                color: Colors.grey,
              )
            : null,
      ),
      children: _children,
    );
  }

  List<Widget> get _children {
    switch (type) {
      case PickerType.hours:
        return _hours;
      case PickerType.minutes:
        return _minutes;
      case PickerType.amOrPm:
        return [
          customTimePickerText(
            'am'.toUpperCase(),
            color: Colors.blueAccent,
            fontWeight: FontWeight.w800,
          ),
          customTimePickerText(
            'pm'.toUpperCase(),
            color: Colors.blueAccent,
            fontWeight: FontWeight.w800,
          ),
        ];
    }
  }

  List<Widget> get _hours => List.generate(
    12,
    (index) =>
        customTimePickerText('${index + 1}'.padLeft(2, '0'), size: 18),
  );
  List<Widget> get _minutes => List.generate(
    60,
        (index) =>
        customTimePickerText('$index'.padLeft(2, '0'), size: 18),
  );
}

enum PickerType { hours, minutes, amOrPm }