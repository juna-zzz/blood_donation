import 'dart:async';
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/constants/app_constants.dart';
import '../helper/keyboard_util.dart';
import '../resources/color_manager.dart';
import '../resources/size_config.dart';
import '../resources/strings_manager.dart';
import '../sign_in/components/sign_in_screen.dart';
import '../widgets/default_button.dart';
import 'terms.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

String? userName;
String? email;
String? password;
String? address;
String? number;
bool isLoading = false;
bool _acceptedTerms = false;

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final phonenumber = TextEditingController();
  String? select;
  void clear() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    addressController.clear();
    phonenumber.clear();
    KeyboardUtil.hideKeyboard(context);
    Get.snackbar('Congratulations', 'Registration Successful',
        snackPosition: SnackPosition.TOP);
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const SignInScreen()));
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void submit() async {
    UserCredential? result;
    try {
      setState(() {
        isLoading = true;
      });
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on PlatformException {
      Get.snackbar('Error', 'Please Check Your Internet Connection',
          snackPosition: SnackPosition.TOP);
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Error', 'User Already Exists',
          snackPosition: SnackPosition.TOP);
    }
    FirebaseFirestore.instance.collection("User").doc(result!.user!.uid).set({
      "userName": nameController.text,
      "userId": result.user!.uid,
      "userEmail": emailController.text,
      "userAddress": addressController.text,
      "bloodGroup": select,
      "userImage": "",
      "points": 0,
      "phoneNumber": phonenumber.text
    });

    setState(() {
      isLoading = false;
      clear();
    });
  }

  List blood = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: ColorManager.kPrimaryColor,
          value: blood[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              select = value;
              log(select.toString());
            });
          },
        ),
        Text(title, style: TextStyle(color: ColorManager.white)),
      ],
    );
  }

  void vaildation() async {
    if (userName.toString().isEmpty) {
      Get.snackbar('Error', 'Enter Username');
    } else if (userName.toString().length < 6) {
      Get.snackbar('Error', 'Username is short');
    } else if (email.toString().isEmpty) {
      Get.snackbar('Error', 'Email Is Empty');
    } else if (!emailValidatorRegExp.hasMatch(email.toString())) {
      Get.snackbar('Error', 'Please Try Vaild Email');
    } else if (password.toString().isEmpty) {
      Get.snackbar('Error', 'Password Is Empty');
    } else if (password.toString().length < 8) {
      Get.snackbar('Error', 'Password  Is Too Short');
    } else {
      if (_acceptedTerms) {
        submit();
      } else {
        Get.snackbar('Error', 'Read and Accept Term and Conditions');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: nameController,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    getProportionateScreenWidth(10),
                    getProportionateScreenWidth(20),
                    getProportionateScreenWidth(10)),
                child: Icon(
                  Icons.person,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
              hintText: AppStrings.userName,
              labelText: AppStrings.userNameTextField,
              hintStyle: TextStyle(color: ColorManager.white),
              labelStyle: TextStyle(color: ColorManager.white),
            ),
            onChanged: (value) {
              setState(() {
                userName = value;
              });
            },
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: emailController,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    getProportionateScreenWidth(10),
                    getProportionateScreenWidth(20),
                    getProportionateScreenWidth(10)),
                child: Icon(
                  Icons.email,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
              hintText: AppStrings.enterEmail,
              labelText: AppStrings.email,
              hintStyle: TextStyle(color: ColorManager.white),
              labelStyle: TextStyle(color: ColorManager.white),
            ),
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: passwordController,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    getProportionateScreenWidth(10),
                    getProportionateScreenWidth(20),
                    getProportionateScreenWidth(10)),
                child: Icon(
                  Icons.lock,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
              hintText: AppStrings.enterPassword,
              labelText: AppStrings.password,
              hintStyle: TextStyle(color: ColorManager.white),
              labelStyle: TextStyle(color: ColorManager.white),
            ),
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: addressController,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    getProportionateScreenWidth(10),
                    getProportionateScreenWidth(20),
                    getProportionateScreenWidth(10)),
                child: Icon(
                  Icons.location_on,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
              hintText: AppStrings.addressTextField,
              labelText: AppStrings.address,
              hintStyle: TextStyle(color: ColorManager.white),
              labelStyle: TextStyle(color: ColorManager.white),
            ),
            onChanged: (value) {
              setState(() {
                address = value;
              });
            },
          ),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: phonenumber,
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    getProportionateScreenWidth(10),
                    getProportionateScreenWidth(20),
                    getProportionateScreenWidth(10)),
                child: Icon(
                  Icons.call,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
              hintText: AppStrings.phoneNumberTextField,
              labelText: AppStrings.phoneNumber,
              hintStyle: TextStyle(color: ColorManager.white),
              labelStyle: TextStyle(color: ColorManager.white),
            ),
            onChanged: (value) {
              setState(() {
                number = value;
              });
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                addRadioButton(0, 'A+'),
                addRadioButton(1, 'A-'),
                addRadioButton(2, 'B+'),
                addRadioButton(3, 'B-'),
                addRadioButton(4, 'O+'),
                addRadioButton(5, 'O-'),
                addRadioButton(6, 'AB+'),
                addRadioButton(7, 'AB-'),
              ],
            ),
          ),
          CheckboxListTile(
            title: Row(
              children: [
                Text(
                  'I accept',
                  style: GoogleFonts.comfortaa(
                      fontSize: 16, color: ColorManager.white),
                ),
                TextButton(
                  child: Text(
                    'terms and conditions',
                    style: GoogleFonts.comfortaa(
                        fontSize: 16, color: ColorManager.kPrimaryColor),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const TermsAndCondition(),
                    );
                  },
                )
              ],
            ),
            value: _acceptedTerms,
            activeColor: ColorManager.kPrimaryColor,
            onChanged: (bool? value) {
              setState(() {
                _acceptedTerms = value!;
              });
            },
          ),
          const SizedBox(
            height: 24,
          ),
          DefaultButton(
            text: AppStrings.signUp,
            press: () {
              if (_formKey.currentState!.validate()) {
                vaildation();
              }
            },
          ),
        ],
      ),
    );
  }
}
