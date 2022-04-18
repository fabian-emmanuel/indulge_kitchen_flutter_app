import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData prefixIcon;
  final bool isObscured;
  const AppTextField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.prefixIcon,
      this.isObscured = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.len20, right: Dimensions.len20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: const Offset(1, 10),
                color: Colors.grey.withOpacity(0.2))
          ],
          borderRadius: BorderRadius.circular(Dimensions.len15)),
      child: TextField(
        obscureText: isObscured,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.len15),
              borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.len15),
              borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.len15),
          ),
        ),
      ),
    );
  }
}
