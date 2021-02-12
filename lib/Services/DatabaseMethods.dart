import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      {String userID,
      String email,
      String username,
      String name,
      String profileUrl}) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .set({
      "email": email,
      "username": username,
      "name": name,
      "imgUrl": profileUrl
    });
  }

  Future getUserNamefromDB(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }
}
