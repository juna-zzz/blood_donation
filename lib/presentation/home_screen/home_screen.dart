import 'package:blood_bank/presentation/chat/chat_page.dart';
import 'package:blood_bank/presentation/home_screen/components/latest.dart';
import 'package:blood_bank/presentation/resources/routes_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/data_controller.dart';
import '../resources/color_manager.dart';
import '../resources/size_config.dart';
import '../widgets/drawer.dart';
import 'components/blood_group.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataController controller = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserProfileData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    return Container(
      color: ColorManager.bgWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: key,
        appBar: AppBar(
          backgroundColor: ColorManager.kSecondaryColor,
          elevation: 10,
          title: Text(
            "HomeScreen",
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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                const Text(
                  'Latest Doners',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                const LatestDonation(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                const Text(
                  'Find Blood Groups',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const BloodGroup(),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
              ],
            ),
          ),
        ),
        drawer: const DrawerWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.donationAdd);
          },
          backgroundColor: ColorManager.kSecondaryColor,
          child: const Icon(Icons.add_chart),
        ),
      ),
    );
  }
}
