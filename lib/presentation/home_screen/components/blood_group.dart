import 'package:blood_bank/presentation/blood_group/a_positive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../blood_group/a_negative.dart';
import '../../blood_group/ab_negative.dart';
import '../../blood_group/ab_positivie.dart';
import '../../blood_group/b_negative.dart';
import '../../blood_group/b_positive.dart';
import '../../blood_group/o_negative.dart';
import '../../blood_group/o_positive.dart';

class BloodGroup extends StatefulWidget {
  const BloodGroup({super.key});

  @override
  State<BloodGroup> createState() => _BloodGroupState();
}

class _BloodGroupState extends State<BloodGroup> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          InkWell(
            onTap: () {
              Get.to(() => const APositive());
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_d6dmxlhi.json'),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const BPositive());
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_6sbcdpys.json'),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const OPositive());
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_ndukurao.json'),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const ANegative());
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_mw3to7io.json'),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const BNegative());
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_wwohioc6.json'),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const ONegative());
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_gze7ffbh.json'),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const ABPositive());
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_qjvnamie.json'),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const ABNegative());
            },
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_0ul52rxa.json'),
            ),
          ),
        ],
      ),
    );
  }
}
