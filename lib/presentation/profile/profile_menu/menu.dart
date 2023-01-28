import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/color_manager.dart';
import '../../resources/size_config.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.085,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: ColorManager.kPrimaryColor,
            padding: const EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: ColorManager.kSecondaryColor,
          ),
          onPressed: press,
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                  child: Text(
                text,
                style: GoogleFonts.comfortaa(
                    fontSize: 18, color: ColorManager.white),
              )),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
