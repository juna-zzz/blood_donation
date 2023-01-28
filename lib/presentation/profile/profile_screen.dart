import 'package:blood_bank/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/drawer.dart';
import 'components/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kSecondaryColor,
        title: Text(
          "Profile",
          style: GoogleFonts.comfortaa(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: ProfileBody(),
      drawer: const DrawerWidget(),
    );
  }
}
