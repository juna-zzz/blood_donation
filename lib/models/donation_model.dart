import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  String? username;
  String? email;
  String? address;
  String? number;
  String? bloodGroup;
  Timestamp? date;

  Donation({
    required this.username,
    required this.email,
    required this.address,
    required this.number,
    required this.bloodGroup,
    this.date,
  });
}
