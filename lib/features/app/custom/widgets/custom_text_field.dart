import 'package:ceiba_technical_test/core/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget with BaseWidget {
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? labelText;
  final String? hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final String? initialValue;
  final TextEditingController? controller;
  final bool isObscure;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  const CustomTextField({
    Key? key,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.labelText,
    this.hintText,
    required this.onChanged,
    this.validator,
    this.initialValue,
    this.controller,
    this.isObscure = false,
    this.suffix,
    this.prefix,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly = false,
    this.onSaved,
    this.onTap,
    this.contentPadding,
    this.hintStyle,
    this.labelStyle,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaseWidget.init(context);
    return TextFormField(
      readOnly: readOnly,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      initialValue: initialValue,
      controller: controller,
      keyboardType: keyboardType,
      style: style,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        suffix: suffix,
        suffixIcon: suffixIcon,
        prefix: prefix,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding,
        hintStyle: hintStyle,
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
    );
  }
}
