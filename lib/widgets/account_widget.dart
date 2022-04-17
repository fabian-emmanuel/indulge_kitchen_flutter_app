import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/app_icon.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.len20),
      padding: EdgeInsets.only(
        left: Dimensions.wit20,
        top: Dimensions.len10,
        bottom: Dimensions.len10,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.wit20),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.len15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              offset: const Offset(0, 2),
              color: Colors.grey.withOpacity(0.3)),
        ],
      ),
    );
  }
}
