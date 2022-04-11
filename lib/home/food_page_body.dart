import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
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
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //======== Slider Section ===============//
        SizedBox(
          height: Dimensions.pageView,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),

        //======== Dots Section ===============//
        DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.len5)),
          ),
        ),

        //======== Popular text Section ===============//
        SizedBox(height: Dimensions.len30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.wit30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(width: Dimensions.len10),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(text: ".", color: Colors.black26)),
              SizedBox(width: Dimensions.len10),
              Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: SmallText(text: "Food pairing")),
            ],
          ),
        ),

        //======== ListView for food and images Section ===============//
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(
              left: Dimensions.len20,
              right: Dimensions.len20,
              bottom: Dimensions.len10,
            ),
            child: Row(
              children: [
                //========= image container =============/
                Container(
                  width: Dimensions.listViewImgSize,
                  height: Dimensions.listViewImgSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.len20),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/image/food0.png"),
                    ),
                  ),
                ),

                //========= image container =============/
                Expanded(
                  child: Container(
                    height: Dimensions.listViewTextContainer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.len20),
                        bottomRight: Radius.circular(Dimensions.len20),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.len10,
                        right: Dimensions.len10,
                        top: Dimensions.len10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: "Nutritional Food Meal In China"),
                          SizedBox(height: Dimensions.len10),
                          SmallText(text: "With Chinese characteristics"),
                          SizedBox(height: Dimensions.len10),
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
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == (_currentPageValue.floor() + 1)) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == (_currentPageValue.floor() - 1)) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
              left: Dimensions.len10,
              right: Dimensions.len10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.len30),
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
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.len30,
                right: Dimensions.len30,
                bottom: Dimensions.len30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.len20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                // color: Colors.amberAccent,
                padding: EdgeInsets.only(
                    top: Dimensions.len15,
                    left: Dimensions.len15,
                    right: Dimensions.len15),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Chinese Side"),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
