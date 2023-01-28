import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/size_config.dart';
import '../resources/strings_manager.dart';
import '../widgets/no_account.dart';
import 'sign_up_form.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://media.istockphoto.com/id/1320162065/vector/blood-cells-red-erythrocytes.jpg?s=612x612&w=0&k=20&c=rX8kGwiOsHW-V-BOal3Cf6ADKdjx_U5snDdykya0jbs="),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    Text(
                      AppStrings.registerAccount,
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: getProportionateScreenWidth(35),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Text(
                      AppStrings.signUpPageText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorManager.white),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    const SignUpForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    const YesAccountText(),
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
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
