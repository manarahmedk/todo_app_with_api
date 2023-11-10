import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'colors.dart';

class Functions {
  static Future<bool?> showToast({required String message, Color? background}) {
    return Fluttertoast.showToast(
      msg: message ?? '',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: background ?? AppColors.background,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }
}