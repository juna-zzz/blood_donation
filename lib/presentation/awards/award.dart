import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/color_manager.dart';
import 'award_body.dart';

class Awards extends StatefulWidget {
  const Awards({super.key});

  @override
  State<Awards> createState() => _AwardsState();
}

class _AwardsState extends State<Awards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kSecondaryColor,
        elevation: 10,
        title: Text(
          "Awards",
          style: GoogleFonts.comfortaa(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
