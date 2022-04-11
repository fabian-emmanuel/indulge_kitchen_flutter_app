import 'package:flutter/material.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';
import 'package:indulge_kitchen/widgets/icon_and_text.dart';
import 'package:indulge_kitchen/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: PageView.builder(
          controller: pageController,
          itemCount: 5,
          itemBuilder: (context, position) {
            return _buildPageItem(position);
          }),
    );
  }

  Widget _buildPageItem(int index) {
    return Stack(
      children: [
        Container(
          height: 220.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: index.isEven
                  ? const Color(0xFF69c5df)
                  : const Color(0xff4bde6c),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/food0.png"))),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 120.0,
            margin: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              bottom: 20.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
            ),
            child: Container(
              // color: Colors.amberAccent,
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: "Chinese Side"),
                  const SizedBox(height: 10),
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
                      const SizedBox(width: 10),
                      SmallText(text: "5.0"),
                      const SizedBox(width: 10),
                      SmallText(text: "1287"),
                      const SizedBox(width: 5),
                      SmallText(text: "comments"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      IconAndTextWidget(
                          icon: Icons.circle_sharp,
                          iconColor: AppColors.iconColor1,
                          text: "Normal"),
                      SizedBox(width: 20.0),
                      IconAndTextWidget(
                          icon: Icons.location_on,
                          iconColor: AppColors.mainColor,
                          text: "17km"),
                      SizedBox(width: 20.0),
                      IconAndTextWidget(
                          icon: Icons.access_time_rounded,
                          iconColor: AppColors.iconColor2,
                          text: "32min"),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
