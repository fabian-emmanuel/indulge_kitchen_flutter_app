import 'package:flutter/material.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';
import 'package:indulge_kitchen/widgets/icon_and_text.dart';
import 'package:indulge_kitchen/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.len26,
        ),
        SizedBox(height: Dimensions.len10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => const Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                        size: 15.0,
                      )),
            ),
            SizedBox(width: Dimensions.len10),
            SmallText(text: "5.0"),
            SizedBox(width: Dimensions.len15),
            SmallText(text: "1287"),
            SizedBox(width: Dimensions.len10),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimensions.len20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                iconColor: AppColors.iconColor1,
                text: "Normal"),
            IconAndTextWidget(
                icon: Icons.location_on,
                iconColor: AppColors.mainColor,
                text: "17km"),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                iconColor: AppColors.iconColor2,
                text: "32min"),
          ],
        )
      ],
    );
  }
}
