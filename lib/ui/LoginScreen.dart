import 'package:appentus_assignment/base/BaseState.dart';
import 'package:appentus_assignment/data/local/UserModel.dart';
import 'package:appentus_assignment/data/local/dao/UserDao.dart';
import 'package:appentus_assignment/res/AppColor.dart';
import 'package:appentus_assignment/res/Dimensions.dart';
import 'package:appentus_assignment/res/Strings.dart';
import 'package:appentus_assignment/util/constants.dart';
import 'package:appentus_assignment/validation/validation.dart';
import 'package:appentus_assignment/widget/BigButtonView.dart';
import 'package:appentus_assignment/widget/EditTextBorder.dart';
import 'package:appentus_assignment/widget/TextView.dart';
import 'package:appentus_assignment/widget/Toolbar.dart';
import 'package:flutter/material.dart';

/*
* Created by Rajat Jain 24/06/2021
 */
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends BaseState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passFocus = new FocusNode();
  UserDao dao = new UserDao();

  @override
  Widget getBuildWidget(BuildContext context) {
    Widget _buildEmailTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          textView(title: Strings.email, fontColor: Colors.white, fontWeight: FontWeight.bold),
          SizedBox(height: 10.0),
          editTextBorder(
            hint: "Enter your email",
            decoration: kBoxDecorationStyle,
            mode: AutovalidateMode.onUserInteraction,
            txtColor: AppColor.white,
            controller: _emailController,
            focus: _emailFocus,
            validator: (value) {
              return validateEmail(value, Strings.emailValidationMsg);
            },
          )
        ],
      );
    }

    Widget _buildPasswordTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          textView(title: Strings.password, fontColor: Colors.white, fontWeight: FontWeight.bold),
          SizedBox(height: 10.0),
          editTextBorder(
            hint: "Enter your password",
            decoration: kBoxDecorationStyle,
            txtColor: AppColor.white,
            mode: AutovalidateMode.onUserInteraction,
            controller: _passwordController,
            focus: _passFocus,
            validator: (value) {
              return validatePassword(value, Strings.passwordValidationMsg);
            },
          )
        ],
      );
    }

    return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF73AEF5),
            Color(0xFF61A4F1),
            Color(0xFF478DE0),
            Color(0xFF398AE5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.4, 0.7, 0.9],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        _buildEmailTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  )),
            ),
            bigButtonView(
                cornerRadius: 40,
                label: Strings.login,
                labelColor: AppColor.primary,
                margin: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
                onClick: () async {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState.validate()) {
                    bool isExist = await dao.checkUser(_emailController.text.trim());

                    if (isExist) {
                      User user = await dao.getUserDetails(_emailController.text.trim());
                      print(user.image);
                      if (_emailController.text.trim() == user.email &&
                          _passwordController.text.trim() == user.password) {
                        showSnackBar("Login Successfully", bgColor: Colors.green);

                        Future.delayed(Duration(milliseconds: 500), () {
                          Navigator.pushReplacementNamed(context, '/home',
                              arguments: "${_emailController.text}");
                        });
                      } else {
                        showSnackBar("Invalid Credentials");
                      }
                    } else {
                      showProgress(false);
                      showSnackBar("User Not Found");
                    }
                  }
                }),
            InkWell(
              onTap: () {
                print("Click");
                Navigator.pushNamed(context, "/signup");
              },
              child: textView(
                  title: "Not User? Create Account",
                  fontColor: AppColor.white,
                  fontSize: Dimensions.txtSize16px,
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.only(bottom: 10)),
            )
          ],
        ));
  }

  @override
  AppBar getToolBar(BuildContext context) {
    return toolBarWithoutIcon(toolBarTitle: Strings.signInTxt);
  }

  @override
  void onScreenReady(BuildContext context) {}
}
