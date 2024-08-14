import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'font_sizes.dart';

class ProjectUtil {

  DateTime toDate({required String dateTime}) {
    final utcDateTime = DateTime.parse(dateTime);
    return utcDateTime.toLocal();
  }

  String formatDate({
    required String dateTime,
    format = "dd MMM, yyyy"
  }) {
    final localDateTime = toDate(dateTime: dateTime);
    return DateFormat(format).format(localDateTime);
  }

  SnackBar getSnackBar(String message, Color backgroundColor) {
    SnackBar snackBar = SnackBar(
      content: Text(message,
          style: const TextStyle(fontSize: textMedium)),
      backgroundColor: backgroundColor,
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
    );
    return snackBar;
  }

  //Status bar color update
  void statusBarColor(
      {Color? statusBarColor,
        Color? navigationBarColor,
        bool isAppStatusDarkBrightness = true,
        bool isNavigationBarDarkBrightness = false}) {
    statusBarColor ??= Colors.transparent;
    navigationBarColor ??= Colors.black;
    if (Platform.isAndroid) {
      try {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarIconBrightness:
          isAppStatusDarkBrightness ? Brightness.dark : Brightness.light,
          systemNavigationBarIconBrightness: isNavigationBarDarkBrightness
              ? Brightness.dark
              : Brightness.light,
          statusBarColor: statusBarColor,
          systemNavigationBarColor: navigationBarColor,
        ));
      } catch (e) {
        print(e);
      }
    } else if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness:
        isAppStatusDarkBrightness ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
        isNavigationBarDarkBrightness ? Brightness.light : Brightness.dark,
        statusBarColor: statusBarColor,
        systemNavigationBarColor: navigationBarColor,
      ));
    }
  }
}

ProjectUtil projectUtil = ProjectUtil();