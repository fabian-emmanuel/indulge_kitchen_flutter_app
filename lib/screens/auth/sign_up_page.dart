import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indulge_kitchen/base/show_custom_snackbar.dart';
import 'package:indulge_kitchen/data/models/sign_up_model.dart';
import 'package:indulge_kitchen/routes/routes_helper.dart';
import 'package:indulge_kitchen/utils/dimensions.dart';
import 'package:indulge_kitchen/widgets/app_text_field.dart';
import 'package:indulge_kitchen/widgets/big_text.dart';
import 'package:indulge_kitchen/widgets/small_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var signUpImg = ['f.png', 'g.png', 't.png'];

    void _registration() {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      SignUpModel model;
      (name.isEmpty)
          ? showCustomSnackBar("Name can't be empty", title: 'Name')
          : (phone.isEmpty)
              ? showCustomSnackBar("PhoneNumber can't be empty",
                  title: 'PhoneNumber')
              : (!GetUtils.isPhoneNumber(phone))
                  ? showCustomSnackBar("PhoneNumber is not valid",
                      title: 'Invalid PhoneNumber')
                  : (email.isEmpty)
                      ? showCustomSnackBar("Email can't be empty",
                          title: 'Email Address')
                      : (!GetUtils.isEmail(email))
                          ? showCustomSnackBar("Email is not valid",
                              title: 'Invalid Email Address')
                          : (password.isEmpty)
                              ? showCustomSnackBar("Password can't be empty",
                                  title: 'Password')
                              : (password.length < 6)
                                  ? showCustomSnackBar(
                                      "Password must be greater than 5 characters",
                                      title: 'Invalid Password')
                                  : {
                                      model = SignUpModel(
                                          name: name,
                                          phone: phone,
                                          email: email,
                                          password: password),
                                      showCustomSnackBar(
                                          "Registration is Successful",
                                          title: 'Perfect',
                                          bgColor: Colors.green)
                                    };
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                    backgroundImage: AssetImage('assets/image/logo part 1.png'),
                  ),
                ),
              ),
              AppTextField(
                  textEditingController: nameController,
                  hintText: 'Name',
                  prefixIcon: CupertinoIcons.person),
              SizedBox(height: Dimensions.len15),
              AppTextField(
                  textEditingController: phoneController,
                  hintText: 'Phone',
                  prefixIcon: CupertinoIcons.phone),
              SizedBox(height: Dimensions.len15),
              AppTextField(
                  textEditingController: emailController,
                  hintText: 'Email',
                  prefixIcon: CupertinoIcons.mail),
              SizedBox(height: Dimensions.len15),
              AppTextField(
                  textEditingController: passwordController,
                  hintText: 'Password',
                  prefixIcon: CupertinoIcons.padlock_solid),
              SizedBox(height: Dimensions.len30),
              GestureDetector(
                onTap: () {
                  _registration();
                },
                child: Container(
                  height: Dimensions.screenHeight / 14,
                  width: Dimensions.screenWidth / 2,
                  child: Center(
                      child: BigText(text: 'Sign Up', color: Colors.white)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.len30),
                    color: Colors.blue.shade300,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.len15),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                      fontSize: Dimensions.len15),
                  text: 'Already Have an account? Sign in',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed(RouteHelper.getSignInPage()),
                ),
              ),
              SizedBox(height: Dimensions.len15),
              BigText(text: '------- OR -------'),
              SizedBox(height: Dimensions.len15),
              SmallText(text: 'Sign up with one of the following'),
              SizedBox(height: Dimensions.len15),
              Wrap(
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: Dimensions.len20,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/image/${signUpImg[index]}'),
                          ),
                        )),
              )
            ],
          ),
        ));
  }
}
