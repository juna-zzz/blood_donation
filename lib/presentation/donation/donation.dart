import 'package:blood_bank/controller/data_controller.dart';
import 'package:blood_bank/models/donation_model.dart';
import 'package:blood_bank/presentation/resources/color_manager.dart';
import 'package:blood_bank/presentation/widgets/default_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Map<String, dynamic>? data;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorManager.kSecondaryColor,
          centerTitle: true,
          title: Text(
            'Donation Form',
            style: TextStyle(
              color: ColorManager.kPrimaryColor,
              fontSize: 24,
            ),
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Ready To Donate",
            style: TextStyle(
                color: ColorManager.kSecondaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User')
                .where("userId", isEqualTo: auth.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  data = document.data()! as Map<String, dynamic>;
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      color: ColorManager.kSecondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data!['userName'].toString().toUpperCase(),
                                  style: TextStyle(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 24,
                                  ),
                                ),
                                const Spacer(),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: ColorManager.kPrimaryColor,
                                  child: Text(
                                    data!['bloodGroup'],
                                    style: TextStyle(
                                        color: ColorManager.kSecondaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              data!['userEmail'],
                              style: TextStyle(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              data!['userAddress'],
                              style: TextStyle(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              data!['phoneNumber'],
                              style: TextStyle(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            DefaultButton(
                                text: 'Submit',
                                press: () {
                                  controller.donate(
                                    Donation(
                                      username: data!['userName'],
                                      email: data!['userEmail'],
                                      address: data!['userAddress'],
                                      number: data!['phoneNumber'],
                                      bloodGroup: data!['bloodGroup'],
                                    ),
                                  );
                                  Get.snackbar(
                                      'Success', 'Thankyou for the donation');
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
