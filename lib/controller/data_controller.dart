import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../models/donation_model.dart';
import '../models/user_model.dart';
import '../presentation/resources/routes_manager.dart';

class DataController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firebaseInstance = FirebaseFirestore.instance;
  List<UserModel> user = [];
  List<UserModel> bloodAP = [];
  List<UserModel> bloodBP = [];
  List<UserModel> bloodOP = [];
  List<UserModel> bloodAN = [];
  List<UserModel> bloodBN = [];
  List<UserModel> bloodON = [];
  List<UserModel> bloodABP = [];
  List<UserModel> bloodABN = [];
  List<Donation> donation = [];

  bool isCart = false;

  @override
  void onReady() {
    super.onReady();
    getUserProfileData();
    getABNegative();
    getABPositive();
    getDonation();
    getAPositive();
    getBPositive();
    getOPositive();
    getANegative();
    getBNegative();
    getONegative();
  }

  Future<void> getUserProfileData() async {
    final List<UserModel> userLoaded = [];
    try {
      var response = await firebaseInstance
          .collection('User')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          userLoaded.add(UserModel(
              userEmail: result['userEmail'],
              userName: result['userName'],
              userAddress: result['userAddress'],
              bloodGroup: result['bloodGroup'],
              phoneNumber: result['phoneNumber']));
        }
      }
      user.addAll(userLoaded);
      update();
    } on FirebaseException {
      // print(e);
    } catch (error) {
      // print(error);
    }
  }

  Future<void> addProfileImage(File image) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    final ref = FirebaseStorage.instance
        .ref()
        .child(auth.currentUser!.uid)
        .child(result);
    var response = await ref.putFile(image);
    log(response.toString());

    var imageUrl = await ref.getDownloadURL();

    try {
      FirebaseFirestore.instance
          .collection('User')
          .doc(auth.currentUser!.uid)
          .update({
        'userImage': imageUrl,
      });
    } catch (exception) {
      return;
    }
  }

  Future<void> donate(Donation donation) async {
    final auth = FirebaseAuth.instance.currentUser!.uid;
    try {
      var response = FirebaseFirestore.instance.collection('Donation').doc();
      var responseUser = firebaseInstance.collection('User').doc(auth);
      responseUser.update({'points': FieldValue.increment(5)});

      response.set({
        "username": donation.username,
        "email": donation.email,
        "address": donation.address,
        "phoneNumber": donation.number,
        "bloodGroup": donation.bloodGroup,
        "timestamp": DateTime.now(),
      });

      update();
    } catch (error) {
      // print("error $error");
    }
  }

  Future getDonation() async {
    donation = [];

    try {
      final List<Donation> allDonation = [];

      final response = await firebaseInstance.collection('Donation').get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          allDonation.add(Donation(
            username: result['username'],
            email: result['email'],
            address: result['address'],
            number: result['phoneNumber'],
            bloodGroup: result['bloodGroup'],
            date: result['timestamp'],
          ));
        }
      }

      donation.addAll(allDonation);

      log(DateTime.fromMicrosecondsSinceEpoch(
              donation[0].date!.microsecondsSinceEpoch)
          .day
          .toString());
      update();
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }

  Future<void> getAPositive() async {
    bloodAP = [];

    try {
      final List<UserModel> data = [];
      var response = await firebaseInstance
          .collection('User')
          .where('bloodGroup', isEqualTo: 'A+')
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          data.add(UserModel(
              userEmail: result['userEmail'],
              userName: result['userName'],
              userAddress: result['userAddress'],
              bloodGroup: result['bloodGroup'],
              phoneNumber: result['phoneNumber']));
        }
      }
      bloodAP.addAll(data);
      update();
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }

  Future<void> getBPositive() async {
    bloodBP = [];

    try {
      final List<UserModel> data = [];
      var response = await firebaseInstance
          .collection('User')
          .where('bloodGroup', isEqualTo: 'B+')
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          data.add(UserModel(
              userEmail: result['userEmail'],
              userName: result['userName'],
              userAddress: result['userAddress'],
              bloodGroup: result['bloodGroup'],
              phoneNumber: result['phoneNumber']));
        }
      }
      bloodBP.addAll(data);
      update();
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }

  Future<void> getOPositive() async {
    bloodOP = [];

    try {
      final List<UserModel> data = [];
      var response = await firebaseInstance
          .collection('User')
          .where('bloodGroup', isEqualTo: 'O+')
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          data.add(UserModel(
              userEmail: result['userEmail'],
              userName: result['userName'],
              userAddress: result['userAddress'],
              bloodGroup: result['bloodGroup'],
              phoneNumber: result['phoneNumber']));
        }
      }
      bloodOP.addAll(data);
      update();
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }

  Future<void> getANegative() async {
    bloodAN = [];

    try {
      final List<UserModel> data = [];
      var response = await firebaseInstance
          .collection('User')
          .where('bloodGroup', isEqualTo: 'A-')
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          data.add(UserModel(
              userEmail: result['userEmail'],
              userName: result['userName'],
              userAddress: result['userAddress'],
              bloodGroup: result['bloodGroup'],
              phoneNumber: result['phoneNumber']));
        }
      }
      bloodAN.addAll(data);
      update();
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }

  Future<void> getBNegative() async {
    bloodBN = [];

    try {
      final List<UserModel> data = [];
      var response = await firebaseInstance
          .collection('User')
          .where('bloodGroup', isEqualTo: 'B-')
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          data.add(UserModel(
              userEmail: result['userEmail'],
              userName: result['userName'],
              userAddress: result['userAddress'],
              bloodGroup: result['bloodGroup'],
              phoneNumber: result['phoneNumber']));
        }
      }
      bloodBN.addAll(data);
      update();
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }

  Future<void> getONegative() async {
    bloodON = [];

    try {
      final List<UserModel> data = [];
      var response = await firebaseInstance
          .collection('User')
          .where('bloodGroup', isEqualTo: 'O-')
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          data.add(UserModel(
              userEmail: result['userEmail'],
              userName: result['userName'],
              userAddress: result['userAddress'],
              bloodGroup: result['bloodGroup'],
              phoneNumber: result['phoneNumber']));
        }
      }
      bloodON.addAll(data);
      update();
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }

  Future<void> getABPositive() async {
    bloodABP = [];

    try {
      final List<UserModel> data = [];
      var response = await firebaseInstance
          .collection('User')
          .where('bloodGroup', isEqualTo: 'AB+')
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          data.add(UserModel(
              userEmail: result['userEmail'],
              userName: result['userName'],
              userAddress: result['userAddress'],
              bloodGroup: result['bloodGroup'],
              phoneNumber: result['phoneNumber']));
        }
      }
      bloodABP.addAll(data);
      update();
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }

  Future<void> getABNegative() async {
    bloodABN = [];

    try {
      final List<UserModel> data = [];
      var response = await firebaseInstance
          .collection('User')
          .where('bloodGroup', isEqualTo: 'AB-')
          .get();

      if (response.docs.isNotEmpty) {
        for (var result in response.docs) {
          data.add(UserModel(
              userEmail: result['userEmail'],
              userName: result['userName'],
              userAddress: result['userAddress'],
              bloodGroup: result['bloodGroup'],
              phoneNumber: result['phoneNumber']));
        }
      }
      bloodABN.addAll(data);
      update();
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }

  Future<void> updateUser(
    String userName,
    String userEmail,
  ) async {
    try {
      await firebaseInstance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"userName": userName, "userEmail": userEmail});
      await auth.currentUser!.updateEmail(userEmail);
      auth.signOut();
      Get.offAndToNamed(Routes.signInRoute);
      Get.snackbar('Success', 'Email Changed Successfully');
    } on FirebaseException catch (e) {
      log("Error $e");
    } catch (error) {
      log("error $error");
    }
  }
}
