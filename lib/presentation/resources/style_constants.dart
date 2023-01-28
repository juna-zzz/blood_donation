import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'size_config.dart';

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.white,
  height: 1.5,
);
final otpInputDecoration = InputDecoration(
    contentPadding:
        EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
    border: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    enabledBorder: outlineInputBorder(),
    labelStyle: TextStyle(color: ColorManager.white),
    hintStyle: TextStyle(color: ColorManager.white));
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: ColorManager.kTextColor),
  );
}
