import 'package:flutter/material.dart';

import '../../../view_model/utils/colors.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  const TextCustom({required this.text, this.fontWeight,Key? key, this.fontSize, this.color=AppColors.white, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight:fontWeight,
        fontSize: fontSize,
        color: color ,
      ),
      textAlign: textAlign,
    );
  }
}
