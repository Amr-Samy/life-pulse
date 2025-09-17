import 'package:flutter/material.dart';

import '../resources/font_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;
  final double? contentPadding;
  final double? fontSize;
  bool isTextHidden;
  String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final String? hintText;
  final String? labelText;
  bool? enableOptions;
  bool? enabled;
  bool? readOnly;
  Function()? onSuffixTap;
  Function()? onTap;
  Function(String? value)? onFieldSubmitted;
  Function(String? value)? onChange;
  Color? backgroundColor ;

   CustomTextField({
    super.key,
    required this.controller,
    this.prefix,
    this.keyboardType,
    required this.hintText,
    this.isTextHidden = false,
    this.validator,
    this.enableOptions,
    this.onSuffixTap,
    this.onFieldSubmitted,
    this.suffix,
    this.inputAction,
    this.onChange,
    this.maxLength,
    this.contentPadding,
    this.enabled,
    this.fontSize,
    this.readOnly,
    this.onTap,
    this.labelText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
           controller: controller,
      focusNode: focusNode,
      obscureText: isTextHidden,
 enabled: enabled,
      enableInteractiveSelection: enableOptions,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChange,
      readOnly: readOnly ?? false,
      onTap: onTap,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      textInputAction: inputAction ?? TextInputAction.done,
      maxLines: 1,
      maxLength:maxLength?? 30,
      style: TextStyle(fontSize: fontSize ?? FontSize.s16),
      decoration: InputDecoration(
        contentPadding:contentPadding !=null? EdgeInsets.symmetric(vertical: contentPadding?? 0) :null,
        counterText: '',
        hintText: hintText,
        filled: true,
        fillColor: backgroundColor ?? Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5),
        ),
      ),
    );
  }
}