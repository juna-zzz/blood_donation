import 'dart:developer';

import 'package:blood_bank/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/data_controller.dart';
import '../chat/chat_page.dart';
import '../home_screen/components/contact_page.dart';

class BPositive extends StatefulWidget {
  const BPositive({super.key});

  @override
  State<BPositive> createState() => _BPositiveState();
}

class _BPositiveState extends State<BPositive> {
  final DataController controller = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getBPositive();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.white, fontSize: 16);
    var list = controller.bloodBP;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kSecondaryColor,
        elevation: 10,
        title: Text(
          "Blood Group",
          style: GoogleFonts.comfortaa(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const ChatPage());
              },
              icon: const Icon(Icons.message)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        log(list[index].phoneNumber.toString());
                        return ContactPage(
                          email: list[index].userEmail,
                          number: list[index].phoneNumber,
                          username: list[index].userName,
                        );
                      }),
                    );
                  },
                  child: ListTile(
                    tileColor: ColorManager.kSecondaryColor,
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorManager.kPrimaryColor,
                      child: Text(list[index].bloodGroup.toString(),
                          style: TextStyle(
                              color: ColorManager.kSecondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    title: Text(
                      list[index].userName.toString(),
                      style: style,
                    ),
                    subtitle: Text(
                      list[index].userEmail.toString(),
                      style: style,
                    ),
                    trailing: Text(
                      list[index].userAddress.toString(),
                      style: style,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
