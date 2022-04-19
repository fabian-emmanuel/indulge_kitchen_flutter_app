import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/base/custom_loader.dart';
import 'package:indulge_kitchen/data/controllers/auth_controller.dart';
import 'package:indulge_kitchen/data/controllers/cart_controller.dart';
import 'package:indulge_kitchen/data/controllers/user_controller.dart';
import 'package:indulge_kitchen/routes/routes_helper.dart';
import 'package:indulge_kitchen/utils/colors.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/account_widget.dart';
import 'package:indulge_kitchen/widgets/app_icon.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isUserLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    (_isUserLoggedIn) ? {Get.find<UserController>().getUserInfo()} : {};
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: Dimensions.len24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _isUserLoggedIn
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                        top: Dimensions.len30, bottom: Dimensions.len30),
                    child: Column(
                      children: [
                        AppIcon(
                          icon: CupertinoIcons.person,
                          iconSize: Dimensions.len45 * 2,
                          size: Dimensions.len45 * 3,
                          iconColor: Colors.white,
                          bgColor: AppColors.mainColor,
                        ),
                        SizedBox(
                          height: Dimensions.len20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: CupertinoIcons.person,
                                    iconSize: Dimensions.len30,
                                    size: Dimensions.len45,
                                    iconColor: Colors.white,
                                    bgColor: Colors.blue.shade300,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.name,
                                  ),
                                ),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: CupertinoIcons.phone_solid,
                                    iconSize: Dimensions.len30,
                                    size: Dimensions.len45,
                                    iconColor: Colors.white,
                                    bgColor: Colors.yellow.shade300,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.phone,
                                  ),
                                ),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: CupertinoIcons.mail,
                                    iconSize: Dimensions.len30,
                                    size: Dimensions.len45,
                                    iconColor: Colors.white,
                                    bgColor: Colors.lightGreenAccent.shade200,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel.email,
                                  ),
                                ),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: CupertinoIcons.location_solid,
                                    iconSize: Dimensions.len30,
                                    size: Dimensions.len45,
                                    iconColor: Colors.white,
                                    bgColor: Colors.orange.shade300,
                                  ),
                                  bigText: BigText(
                                    text: '12 Florence Street, Hanguie',
                                  ),
                                ),
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: CupertinoIcons.chat_bubble_text,
                                    iconSize: Dimensions.len30,
                                    size: Dimensions.len45,
                                    iconColor: Colors.white,
                                    bgColor: AppColors.mainColor,
                                  ),
                                  bigText: BigText(
                                    text: 'Messages',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    (Get.find<AuthController>()
                                            .isUserLoggedIn())
                                        ? {
                                            Get.find<AuthController>()
                                                .clearSharedData(),
                                            Get.find<CartController>().clear(),
                                            Get.find<CartController>()
                                                .clearCartHistory(),
                                            Get.offNamed(
                                                RouteHelper.getSignInPage())
                                          }
                                        : {};
                                  },
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout,
                                      iconSize: Dimensions.len30,
                                      size: Dimensions.len45,
                                      iconColor: Colors.white,
                                      bgColor: Colors.redAccent,
                                    ),
                                    bigText: BigText(
                                      text: 'Log Out',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const CustomLoader())
            : Center(
                child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Dimensions.len20 * 8,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          left: Dimensions.wit20, right: Dimensions.wit20),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/image/signintocontinue.png'))),
                    ),
                    SizedBox(height: Dimensions.len15),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getSignInPage());
                      },
                      child: Container(
                        height: Dimensions.len20 * 3,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                            left: Dimensions.wit20, right: Dimensions.wit20),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.len15),
                        ),
                        child: Center(
                            child: BigText(
                                text: 'Sign in',
                                color: Colors.white,
                                size: Dimensions.len24)),
                      ),
                    ),
                  ],
                ),
              ));
      }),
    );
  }
}
