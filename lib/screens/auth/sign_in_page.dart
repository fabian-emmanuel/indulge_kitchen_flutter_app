import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/base/custom_loader.dart';
import 'package:indulge_kitchen/base/show_custom_snackbar.dart';
import 'package:indulge_kitchen/data/controllers/auth_controller.dart';
import 'package:indulge_kitchen/routes/routes_helper.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/app_text_field.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';
import 'package:indulge_kitchen/widgets/small_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if ((email.isEmpty)) {
        showCustomSnackBar("Email can't be empty", title: 'Email Address');
      } else if ((!GetUtils.isEmail(email))) {
        showCustomSnackBar("Email is not valid",
            title: 'Invalid Email Address');
      } else if (password.isEmpty) {
        showCustomSnackBar("Password can't be empty", title: 'Password');
      } else if ((password.length < 6)) {
        showCustomSnackBar("Password must be greater than 5 characters",
            title: 'Invalid Password');
      } else {
        // SignInModel model = SignInModel(email: email, password: password);
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: Dimensions.len20 * 4,
                            backgroundImage: const AssetImage(
                                'assets/image/logo part 1.png'),
                          ),
                        ),
                      ),
                      Container(
                        width: Dimensions.screenWidth,
                        margin: EdgeInsets.only(left: Dimensions.wit20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: 'Welcome!', size: Dimensions.len45),
                            SizedBox(height: Dimensions.len5),
                            SmallText(
                              text: 'Please Enter your details to Sign in',
                              size: Dimensions.len15,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.len45),
                      AppTextField(
                          textEditingController: emailController,
                          hintText: 'Email',
                          prefixIcon: CupertinoIcons.mail),
                      SizedBox(height: Dimensions.len15),
                      AppTextField(
                          isObscured: true,
                          textEditingController: passwordController,
                          hintText: 'Password',
                          prefixIcon: CupertinoIcons.padlock_solid),
                      SizedBox(height: Dimensions.len45 * 2),
                      GestureDetector(
                        onTap: () {
                          _login(_authController);
                        },
                        child: Container(
                          height: Dimensions.screenHeight / 14,
                          width: Dimensions.screenWidth / 3,
                          child: Center(
                              child: BigText(
                                  text: 'Sign In', color: Colors.white)),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.len15),
                            color: Colors.blue.shade300,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.len30),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500,
                              fontSize: Dimensions.len15),
                          text: 'Not Registered? Create an account?',
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => Get.toNamed(RouteHelper.getSingUpPage()),
                        ),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
