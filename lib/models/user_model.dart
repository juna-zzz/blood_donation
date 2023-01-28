class UserModel {
  String? userName;
  String? userEmail;
  String? bloodGroup;
  String? userAddress;
  String? userId;
  String? userImage;

  String? phoneNumber;

  UserModel({
    this.userId,
    required this.userEmail,
    required this.userName,
    required this.userAddress,
    required this.bloodGroup,
    required this.phoneNumber,
    this.userImage,
  });
}
