import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  SmallText({Key? key,
    required this.text,
    this.color = const Color(0xFFccc7c5),
    this.size = 12.0,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'Roboto',
        height: height,
      ),
    );
  }
}
