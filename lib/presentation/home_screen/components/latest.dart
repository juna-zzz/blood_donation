import 'package:blood_bank/presentation/home_screen/components/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/data_controller.dart';
import '../../resources/color_manager.dart';

class LatestDonation extends StatefulWidget {
  const LatestDonation({super.key});

  @override
  State<LatestDonation> createState() => _LatestDonationState();
}

class _LatestDonationState extends State<LatestDonation> {
  @override
  Widget build(BuildContext context) {
    final DataController controller = Get.find();
    initState() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        controller.getDonation();
      });
    }

    return Container(
        color: Colors.white,
        height: 140,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.donation.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return ContactPage(
                        email: controller.donation[index].email!,
                        number: controller.donation[index].number!,
                        username: controller.donation[index].username!,
                      );
                    }),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  color: ColorManager.kSecondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: ColorManager.kPrimaryColor,
                          child: Text(
                            controller.donation[index].bloodGroup!,
                            style: TextStyle(
                                color: ColorManager.kSecondaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Address: ',
                                  style: TextStyle(
                                      color: ColorManager.kPrimaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.donation[index].address!,
                                  style: TextStyle(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Email: ',
                                  style: TextStyle(
                                      color: ColorManager.kPrimaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.donation[index].email!,
                                  style: TextStyle(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
