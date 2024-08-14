import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

abstract class AppIcons {

  static const String splashScreenIcon = 'assets/icons/splash_icon.svg';
  static const String deleteIcon = 'assets/icons/delete.svg';
  static const String backArrowIcon = 'assets/icons/back_arrow.svg';
  static const String filterIcon = 'assets/icons/filter.svg';
  static const String verticalMenuIcon = 'assets/icons/vertical_menu.svg';
  static const String editIcon = 'assets/icons/edit.svg';

  static dynamic iconImage(
      {required String imageUrl,
        Size? iconSize,
        Color? imageColor,
        bool isFile = false}) {
    return isFile
        ? FileImage(
      File(imageUrl),
      scale: 1,
    )
        : (iconSize != null
        ? (imageUrl.contains(".svg")
        ? SvgPicture.asset(
      imageUrl,
      height: iconSize.height,
      width: iconSize.width
    )
        : Image(
      image: AssetImage(imageUrl),
      height: iconSize.height,
      width: iconSize.height,
      color: imageColor,
    ))
        : (imageUrl.contains(".svg")
        ? SvgPicture.asset(
      imageUrl,
      color: imageColor,
    )
        : Image(
      image: AssetImage(imageUrl),
      color: imageColor,
    )));
  }

  static SvgPicture iconSvgProvider(
      {required String imageUrl,
        Size? iconSize,
        Color? imageColor,
        bool? isFile = false}) {
    return SvgPicture.asset(
      imageUrl,
      height: iconSize?.height,
      width: iconSize?.width
    );
  }
}