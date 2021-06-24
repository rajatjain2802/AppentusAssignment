import 'dart:io';

import 'package:appentus_assignment/base/BaseState.dart';
import 'package:appentus_assignment/data/local/UserModel.dart';
import 'package:appentus_assignment/data/local/dao/UserDao.dart';
import 'package:appentus_assignment/res/AppColor.dart';
import 'package:appentus_assignment/res/Strings.dart';
import 'package:appentus_assignment/validation/validation.dart';
import 'package:appentus_assignment/widget/BigButtonView.dart';
import 'package:appentus_assignment/widget/BuildTextField.dart';
import 'package:appentus_assignment/widget/ImageViewAssets.dart';
import 'package:appentus_assignment/widget/PickImageBottomSheet.dart';
import 'package:appentus_assignment/widget/Toolbar.dart';
import 'package:flutter/material.dart';

/*
* Created by Rajat Jain 24/06/2021
 */
class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreenState();
  }
}

class _RegistrationScreenState extends BaseState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _numberController = new TextEditingController();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passFocus = new FocusNode();
  FocusNode _nameFocus = new FocusNode();
  FocusNode _numberFocus = new FocusNode();
  UserDao dao = new UserDao();
  User user = new User();

  @override
  Widget getBuildWidget(BuildContext context) {
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
            Container(
              height: kToolbarHeight,
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                  color: Colors.white70),
                              width: 90,
                              height: 90,
                              child: ClipOval(
                                child: user.image != null && user.image.isNotEmpty
                                    ? imageViewFile(
                                        imagePath: new File(user.image),
                                        imageWidth: 90,
                                        imageHeight: 90,
                                        fit: BoxFit.contain)
                                    : imageViewAsset(
                                        imagePath: 'assets/images/profile_dummy.jpg',
                                        imageHeight: 90,
                                        imageWidth: 90,
                                        fit: BoxFit.contain),
                              ),
                            ),
                            user.image != null && user.image.isNotEmpty
                                ? Container()
                                : InkWell(
                                    onTap: () {
                                      pickImageFromDeviceBottomSheet(context).then((value) {
                                        if (null != value) {
                                          print(value.path);
                                          user.image = value.path;
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: Colors.white70),
                                      width: 90,
                                      height: 90,
                                      child: Center(
                                        child: Icon(Icons.edit),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        buildTF(
                          label: Strings.name,
                          controller: _nameController,
                          hint: "Enter Your Name",
                          focusNode: _nameFocus,
                          icon: Icons.person,
                          validationFunc: (d) {
                            return validateName(d, Strings.nameValidationMsg);
                          },
                        ),
                        buildTF(
                          label: Strings.number,
                          controller: _numberController,
                          hint: "Enter Your Contact No.",
                          focusNode: _numberFocus,
                          maxLength: 10,
                          inputType: TextInputType.number,
                          icon: Icons.contact_phone,
                          validationFunc: (d) {
                            return validateMobile(d, Strings.mobileValidationMsg);
                          },
                        ),
                        buildTF(
                          label: Strings.email,
                          controller: _emailController,
                          hint: "Enter Your Email",
                          icon: Icons.email,
                          focusNode: _emailFocus,
                          validationFunc: (d) {
                            return validateEmail(d, Strings.emailValidationMsg);
                          },
                        ),
                        buildTF(
                          label: Strings.password,
                          controller: _passwordController,
                          hint: "Enter Your Password",
                          icon: Icons.lock,
                          focusNode: _passFocus,
                          validationFunc: (d) {
                            return validatePassword(d, Strings.passwordValidationMsg);
                          },
                        ),
                      ],
                    ),
                  )),
            ),
            bigButtonView(
                cornerRadius: 40,
                label: Strings.signUpTxt,
                labelColor: AppColor.primary,
                margin: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 10),
                onClick: () async {
                  if (_formKey.currentState.validate()) {
                    bool isExist = await dao.checkUser(_emailController.text.trim());

                    if (!isExist) {
                      user.name = _nameController.text.trim();
                      user.email = _emailController.text.trim();
                      user.password = _passwordController.text.trim();
                      user.number = _numberController.text.trim();

                      dao.createUser(user);
                      showSnackBar("User Created Successfully", bgColor: Colors.green);
                      clearData();
                      Future.delayed(Duration(milliseconds: 500), () {
                        Navigator.of(context).pop();
                      });
                    } else {
                      showSnackBar("User Already Exist");
                    }
                  }
                }),
          ],
        ));
  }

  @override
  AppBar getToolBar(BuildContext context) {
    return toolBar(
        toolBarTitle: Strings.signUpTxt,
        onClick: () {
          performBack(context);
        });
  }

  @override
  void onScreenReady(BuildContext context) {}

  void clearData() {
    _nameController.text = '';
    _emailController.text = '';
    _passwordController.text = '';
    _numberController.text = '';
    user = new User();
  }
}
