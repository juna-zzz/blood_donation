import 'package:blood_bank/presentation/chat/message.dart';
import 'package:blood_bank/presentation/resources/color_manager.dart';
import 'package:blood_bank/presentation/resources/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/data_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final DataController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserProfileData();
    });
    final fs = FirebaseFirestore.instance;
    final TextEditingController message = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kSecondaryColor,
        title: const Text(
          'Message Center',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.79,
                child: Message(
                  email: controller.user[0].userEmail!,
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    child: TextFormField(
                      style: TextStyle(color: ColorManager.kPrimaryColor),
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.kSecondaryColor,
                        hintText: 'Message',
                        hintStyle: TextStyle(color: ColorManager.kPrimaryColor),
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorManager.kPrimaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorManager.kPrimaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        message.text = value!;
                      },
                    ),
                  ),
                  Positioned(
                    right: 5,
                    child: IconButton(
                      onPressed: () {
                        if (message.text.isNotEmpty) {
                          fs.collection('Messages').doc().set({
                            'message': message.text.trim(),
                            'time': DateTime.now(),
                            'email': controller.user[0].userEmail!,
                            'blood': controller.user[0].bloodGroup
                          });
                          message.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send_sharp,
                        size: 25,
                        color: ColorManager.kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
