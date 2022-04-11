import 'package:flutter/material.dart';
import 'package:indulge_kitchen/home/food_page_body.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';
import 'package:indulge_kitchen/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(

            child: Container(
              margin: const EdgeInsets.only(top: 45.0, bottom: 15.0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "Nigeria", color: AppColors.mainColor,),
                      Row(
                        children: [
                          SmallText(text: "Lagos", color: Colors.black54,),
                          const Icon(Icons.arrow_drop_down_rounded),
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      child: const Icon(Icons.search, color: Colors.white),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const FoodPageBody(),
        ],
      )
    );
  }
}
