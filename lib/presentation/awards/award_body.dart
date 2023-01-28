import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/data_controller.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final DataController controller = Get.find();
  Map<String, dynamic>? data;
  int points = 0;
  String? medal;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserProfileData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('User')
              .where("userId",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            } else {}
            return Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                data = document.data()! as Map<String, dynamic>;
                points = data!['points'];
                if (points >= 5 && points <= 50) {
                  medal = 'Bronze';
                } else if (points > 50 && points <= 100) {
                  medal = 'Siver';
                } else if (points > 100) {
                  medal = 'Gold';
                } else {
                  medal = 'none';
                }
                return SizedBox(
                  height: 80,
                  child: Card(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Your Reward Points: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            data!['points'].toString(),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                );
              }).toList(),
            );
          },
        ),
        SizedBox(
          height: 80,
          child: Card(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Your Total Donations: ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                (points / 5).toStringAsFixed(0),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
        medal == 'Bronze'
            ? SizedBox(
                height: 200,
                width: 180,
                child: Card(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                            'https://assets10.lottiefiles.com/packages/lf20_lkdnejbq.json')
                      ]),
                ),
              )
            : const SizedBox(),
        medal == 'Silver'
            ? SizedBox(
                height: 200,
                width: 180,
                child: Card(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                            'https://assets10.lottiefiles.com/packages/lf20_sYpEFh.json')
                      ]),
                ),
              )
            : const SizedBox(),
        medal == 'Gold'
            ? SizedBox(
                height: 200,
                width: 180,
                child: Card(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                            'https://assets10.lottiefiles.com/packages/lf20_aqAp8Z.json')
                      ]),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
