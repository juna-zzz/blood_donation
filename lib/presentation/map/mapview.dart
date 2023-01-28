import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  final LatLng _center =
      const LatLng(27.7172, 85.3240); // center of Chabhail, Nepal
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(const Marker(
        markerId: MarkerId("1"),
        position: LatLng(27.7172,
            85.3240), // set the position of the marker (latitude and longitude)
        infoWindow: InfoWindow(
            title: "Blood Donation Center 1",
            snippet: "Chabhail, Kathmandu, Nepal")));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
