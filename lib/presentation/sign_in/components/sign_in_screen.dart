import 'package:flutter/material.dart';

import 'sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://media.istockphoto.com/id/1320162065/vector/blood-cells-red-erythrocytes.jpg?s=612x612&w=0&k=20&c=rX8kGwiOsHW-V-BOal3Cf6ADKdjx_U5snDdykya0jbs="),
              fit: BoxFit.cover)),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: SignInBody(),
      ),
    );
  }
}
