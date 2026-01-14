import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTimePickerText(
  String value, {
  double? size,
  Color? color,
  FontWeight? fontWeight,
}) => Text(
  value,
  style: TextStyle(
    fontSize: 14,
    color: Colors.black54,
    fontWeight: FontWeight.w500,
  ),
);
