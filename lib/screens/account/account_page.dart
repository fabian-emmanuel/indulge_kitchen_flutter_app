import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/data/controllers/auth_controller.dart';
import 'package:indulge_kitchen/data/controllers/cart_controller.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: 'Profile',
          size: Dimensions.len24,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin:
            EdgeInsets.only(top: Dimensions.len30, bottom: Dimensions.len30),
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
                        text: 'John Doe',
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
                        text: '+12345678910',
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
                        text: 'johndoe@gmail.com',
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
                        (Get.find<AuthController>().isUserLoggedIn())
                            ? {
                                Get.find<AuthController>().clearSharedData(),
                                Get.find<CartController>().clear(),
                                Get.find<CartController>().clearCartHistory(),
                                Get.offNamed(RouteHelper.getSignInPage())
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
      ),
    );
  }
}
