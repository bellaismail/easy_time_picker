import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_cupertino_picker.dart';

class CustomCupertinoTimePicker extends StatefulWidget {
  const CustomCupertinoTimePicker({
    super.key,
    required this.selectedTime,
    required this.onChange,
    this.confirmationWidget,
    this.confirmationText,
    this.picketHeadLabel,
    this.picketHeadLabelStyle,
  }) : assert(
         confirmationWidget != null && confirmationText == null ||
             confirmationWidget == null,
       ),
       assert(
         (picketHeadLabel == null && picketHeadLabelStyle == null) ||
             picketHeadLabel != null,
       );

  final TimeOfDay? selectedTime;
  final Function(TimeOfDay time) onChange;
  final Widget? confirmationWidget;
  final String? confirmationText;
  final String? picketHeadLabel;
  final TextStyle? picketHeadLabelStyle;

  @override
  State<CustomCupertinoTimePicker> createState() =>
      _CustomCupertinoTimePickerState();
}

class _CustomCupertinoTimePickerState extends State<CustomCupertinoTimePicker> {
  late TimeOfDay _selectedTime;
  final nowTime = TimeOfDay.now();
  late TimeOfDay rightTimeForInit;
  late FixedExtentScrollController _hoursController;
  late FixedExtentScrollController _minutesController;
  late FixedExtentScrollController _amOrPmController;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.selectedTime ?? nowTime;
    rightTimeForInit = widget.selectedTime ?? nowTime;
    _initControllers;
  }

  void get _initControllers {
    _hoursController = FixedExtentScrollController();
    _minutesController = FixedExtentScrollController();
    _amOrPmController = FixedExtentScrollController();
    _animate;
  }

  Future<void> get _animate async {
    Future.delayed(const Duration(milliseconds: 400), () async {
      await _hoursController.animateToItem(
        _initHour - 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      await _minutesController.animateToItem(
        _initMinutes,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      await _amOrPmController.animateToItem(
        _initAmOrPm,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  int get _initHour {
    if (rightTimeForInit.hour == 0) {
      return 12;
    } else if (rightTimeForInit.hour > 12) {
      return rightTimeForInit.hour - 12;
    } else {
      return rightTimeForInit.hour;
    }
  }

  int get _initMinutes => rightTimeForInit.minute;

  int get _initAmOrPm {
    if (rightTimeForInit.hour == 0 || rightTimeForInit.hour < 12) {
      return 0;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
                if (widget.picketHeadLabel != null)
                  Text(
                    widget.picketHeadLabel!,
                    style:
                        widget.picketHeadLabelStyle ??
                        Theme.of(context).textTheme.headlineLarge,
                  ),
              ],
            ),
            SizedBox(
              height: 200,
              child: Localizations.override(
                context: context,
                locale: Locale('en'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: CustomCupertinoPicker.hours(
                            controller: _hoursController,
                            onSelect: (hour) {
                              if (_amOrPmController.selectedItem == 0) {
                                if (hour == 12) {
                                  _selectedTime = _selectedTime.replacing(
                                    hour: int.parse(
                                      0.toString().padLeft(2, '0'),
                                    ),
                                  );
                                } else {
                                  _selectedTime = _selectedTime.replacing(
                                    hour: hour,
                                  );
                                }
                              } else {
                                if (hour != 12) {
                                  _selectedTime = _selectedTime.replacing(
                                    hour: hour + 12,
                                  );
                                } else {
                                  _selectedTime = _selectedTime.replacing(
                                    hour: hour,
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(':'),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 100,
                          child: CustomCupertinoPicker.minutes(
                            controller: _minutesController,
                            onSelect: (minutes) {
                              _selectedTime = _selectedTime.replacing(
                                minute: minutes,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                      child: CustomCupertinoPicker.amOrPm(
                        controller: _amOrPmController,
                        onSelect: (index) {
                          int hours = _selectedTime.hour;
                          int calculatedHours = hours;

                          if (index == 0) {
                            if (hours == 12) {
                              calculatedHours = 0;
                            } else if (hours > 12) {
                              calculatedHours = hours - 12;
                            } else {
                              calculatedHours = hours;
                            }
                          } else {
                            if (hours == 0) {
                              calculatedHours = 12;
                            } else if (hours < 12) {
                              calculatedHours = hours + 12;
                            } else {
                              calculatedHours = hours;
                            }
                          }
                          _selectedTime = _selectedTime.replacing(
                            hour: calculatedHours,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                widget.onChange(_selectedTime);
                Navigator.pop(context);
              },
              child:
                  widget.confirmationWidget ??
                  ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.blueAccent,
                      ),
                    ),
                    child: Text(
                      widget.confirmationText ?? 'choose',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
