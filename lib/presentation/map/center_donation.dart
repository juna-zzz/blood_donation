import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';

class DonationCenter extends StatefulWidget {
  const DonationCenter({super.key});

  @override
  State<DonationCenter> createState() => _DonationCenterState();
}

class _DonationCenterState extends State<DonationCenter> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
    _markers.add(
      const Marker(
          markerId: MarkerId("1"),
          position: LatLng(27.716999, 85.346788),
          infoWindow: InfoWindow(
              title: "Blood Donation Center 1",
              snippet: "Chabhail, Kathmandu, Nepal")),
    );
    _markers.add(
      const Marker(
          markerId: MarkerId("2"),
          position: LatLng(27.717482, 85.347485),
          infoWindow: InfoWindow(
              title: "Blood Donation Center 2",
              snippet: "Chabhail, Kathmandu, Nepal")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kSecondaryColor,
        elevation: 10,
        title: Text(
          "Donation Centers",
          style: GoogleFonts.comfortaa(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(27.716999, 85.346788),
          zoom: 18.0,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 100),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.donationAdd);
            },
            backgroundColor: ColorManager.kSecondaryColor,
            child: const Icon(Icons.add_chart),
          ),
        ),
      ),
    );
  }
}
