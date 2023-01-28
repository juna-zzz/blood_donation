import 'package:blood_bank/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  AboutUsPageState createState() => AboutUsPageState();
}

class AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kSecondaryColor,
        centerTitle: true,
        title: Text(
          'About Us',
          style: GoogleFonts.comfortaa(color: Colors.white, fontSize: 28),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome to our About Us page!',
              style: GoogleFonts.comfortaa(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              child: Lottie.network(
                  'https://assets7.lottiefiles.com/packages/lf20_LWQZg8blao.json'),
            ),
            const SizedBox(height: 16.0),
            Text(
                "Welcome to our blood donation app! Our mission is to connect willing donors with those in need of life-saving blood transfusions. We believe that every person has the power to make a difference in someone else's life, and our app makes it easy and convenient for you to do just that Our user-friendly interface allows you to quickly and easily find blood donation centers near you, as well as schedule appointments and track your donation history. We also provide educational resources on the importance of blood donation and the donation process itself. We are a dedicated team of individuals who are passionate about making a positive impact on our communities. We are constantly working to improve our app and make the donation process as smooth as possible for our users. We are grateful for your support and are honored to play a small role in saving lives. Thank you for choosing to make a difference with our blood donation app.",
                textAlign: TextAlign.justify,
                style: GoogleFonts.comfortaa()),
            const SizedBox(height: 30.0),
            Text(
              'Thank you for using our app!',
              style: GoogleFonts.comfortaa(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
