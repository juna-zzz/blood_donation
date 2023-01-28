import 'package:blood_bank/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  String? username;
  String? email;
  String? number;
  ContactPage(
      {super.key,
      required this.email,
      required this.number,
      required this.username});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    String telUrl = 'tel:977${widget.number}';
    String mailUrl = 'mailto:${widget.email}';
    void launchDailer() async {
      if (!await launchUrl(Uri.parse(telUrl))) throw 'Could not launch';
    }

    void launchMail() async {
      if (!await launchUrl(Uri.parse(mailUrl))) throw 'Could not launch';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kSecondaryColor,
        elevation: 10,
        title: Text(
          "Contact",
          style: GoogleFonts.comfortaa(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: Stack(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                widget.username.toString().toUpperCase(),
                style: TextStyle(fontSize: 40, color: ColorManager.white),
              ),
              Text(
                widget.email.toString(),
                style: TextStyle(fontSize: 40, color: ColorManager.white),
              ),
              const Spacer(),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Call'),
                    IconButton(
                        onPressed: () {
                          launchDailer();
                        },
                        icon: const Icon(Icons.call))
                  ],
                ),
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Email'),
                    IconButton(
                        onPressed: () {
                          launchMail();
                        },
                        icon: const Icon(Icons.mail))
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
