import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_cupertino_time_picker_widgets/custom_cupertino_time_picker.dart';

extension EasyTimePicker on BuildContext {
  Future<void> showEasyTimePicker({
    TimeOfDay? selectedTime,
    required Function(TimeOfDay time) onSelect,
    String? confirmationText,
    Widget? confirmationWidget,
    String? picketHeadLabel,
    TextStyle? picketHeadLabelStyle,
  }) async => await showCupertinoModalPopup<TimeOfDay>(
    context: this,
    barrierColor: Colors.grey.withValues(alpha: 0.5),
    builder: (context) => CustomCupertinoTimePicker(
      selectedTime: selectedTime,
      confirmationText: confirmationText,
      confirmationWidget: confirmationWidget,
      picketHeadLabel: picketHeadLabel,
      picketHeadLabelStyle: picketHeadLabelStyle,
      onChange: (time) {
        selectedTime = time;
        onSelect(time);
      },
    ),
  );
}