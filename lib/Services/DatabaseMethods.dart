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

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessage(String chatRoomId, Map lastMessageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  generateChatRoom(String chatRoomId, Map chatRoomInfo) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapshot.exists) {
      return false;
    } else {
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfo);
    }
  }

  Future getMessagesFromChatromm(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .get();
  }
}
