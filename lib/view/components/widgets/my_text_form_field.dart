import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view_model/utils/colors.dart';

class MyTextFormField extends StatefulWidget {
  String? hintText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  IconData? prefixIcon;
  IconData? suffixIcon;
  IconData? secondSuffixIcon;
  bool obscureText;
  String? Function(String?)? validator;
  void Function()? onTap;
  String? initialValue;
  bool readOnly;

  AutovalidateMode? autovalidateMode;

  MyTextFormField({
    this.hintText,
    this.keyboardType,
    this.controller,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.secondSuffixIcon,
    this.validator,
    this.onTap,
    this.initialValue,
    this.readOnly = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        cursorColor: AppColors.orange,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        autofocus: false,
        readOnly: widget.readOnly,
        obscureText: widget.obscureText,
        initialValue: widget.initialValue,
        decoration: InputDecoration(
          isDense: true,
          labelText: widget.hintText,
          floatingLabelStyle: const TextStyle(
            color: AppColors.orange,
          ),
          labelStyle: const TextStyle(
            color: AppColors.orange,
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: AppColors.grey,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            },
            icon: Icon(
              widget.obscureText ? widget.suffixIcon : widget.secondSuffixIcon,
              color: widget.obscureText ? AppColors.orange : AppColors.grey,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
              width: 2,
            ),
          ),
        ),
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator,
        onTap: widget.onTap,
      ),
    );
  }
}
