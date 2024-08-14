import 'package:flutter/material.dart';

import '../application/utils/app_color.dart';
import '../application/utils/font_sizes.dart';


class BuildTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final Color fillColor;
  final Color hintColor;
  final int? maxLength;
  final Function onChange;
  final String? errorMessage;

  const BuildTextField(
      {super.key,
        required this.hint,
        this.controller,
        required this.inputType,
        this.prefixIcon,
        this.suffixIcon,
        this.obscureText = false,
        this.enabled = true,
        this.fillColor = dWhiteColor,
        this.hintColor = dGrey1,
        this.maxLength,
        required this.onChange,this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        onChange(value);
      },
      validator: (val) => val!.isEmpty ? 'required' : null,
      keyboardType: inputType,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: inputType == TextInputType.multiline ? 3 : 1,
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        counterText: "",
        fillColor: fillColor,
        filled: true,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        hintText: hint,
        // errorText: errorMessage ?? "",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: textMedium,
          fontWeight: FontWeight.w300,
          color: hintColor,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(
          fontSize: textMedium,
          fontWeight: FontWeight.normal,
          color: dRed,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 1, color: dPrimaryColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 0, color: fillColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 0, color: dGrey1),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 0, color: dGrey1)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: dRed)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: dGrey1)),
        focusColor: dWhiteColor,
        hoverColor: dWhiteColor,
      ),
      cursorColor: dPrimaryColor,
      style: const TextStyle(
        fontSize: textMedium,
        fontWeight: FontWeight.normal,
        color: dBlackColor,
      ),
    );
  }
}