import 'package:flutter/material.dart';
import 'package:todo_app/view/components/widgets/text_custom.dart';

import '../../../view_model/utils/colors.dart';

class StatisticsWidget extends StatelessWidget {
  final String text;
  final Color? color;

  const StatisticsWidget({
    required this.text,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: color,
            ),
            height: 25,
            width: 25,
          ),
           TextCustom(
            text: text,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
