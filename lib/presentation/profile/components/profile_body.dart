import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/size_config.dart';
import '../profile_menu/menu.dart';

class ProfileBody extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic>? data;

  ProfileBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('User')
              .where("userId", isEqualTo: auth.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            } else {}
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                color: ColorManager.kSecondaryColor.withOpacity(0.9),
                elevation: 10,
                child: Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    data = document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(data!['userImage']),
                          ),
                          Column(
                            children: [
                              Text(
                                data!['userName'].toString().toUpperCase(),
                                style: GoogleFonts.comfortaa(
                                  color: ColorManager.white,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                data!['userEmail'],
                                style: GoogleFonts.comfortaa(
                                  color: ColorManager.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Blood Group : ${data!['bloodGroup']}',
                                style: GoogleFonts.comfortaa(
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
        ProfileMenu(
          text: "Edit Account",
          press: () => {Navigator.pushNamed(context, Routes.profileView)},
        ),
        ProfileMenu(
          text: "Awards",
          press: () => {Navigator.pushNamed(context, Routes.awards)},
        ),
        ProfileMenu(
          text: "Help Center",
          press: () {},
        ),
        ProfileMenu(
          text: "Log Out",
          press: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.signInRoute, (Route<dynamic> route) => false);
          },
        ),
        const Spacer(),
      ],
    );
  }
}
