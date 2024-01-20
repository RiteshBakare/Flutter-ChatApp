import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          final user = doc.data();
          return user;
        }).toList();
      },
    );
  }

  Future<void> sendMessage(String reciverId, message) async {
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create new message
    Message newMessage = Message(
      senderID: currentUserId,
      senderEmail: currentUserEmail,
      reciverID: reciverId,
      message: message,
      timestamp: timestamp,
    );

    // construct a chat room ID for two users
    List<String> ids = [currentUserId, reciverId];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message to database !!!
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join('_');
    print("CHAT ROOM ID: $chatRoomID");
    Stream<QuerySnapshot> ans = _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();

    // Map<String, dynamic> a = ans.first as Map<String, dynamic>;
    // print("ABC: " + a.entries.first.toString());

    return ans;
  }

  Stream<QuerySnapshot> getMSG(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join('_');
    final cloud = FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .withConverter<Message>(
          fromFirestore: (snapshots, _) => Message.fromJson(snapshots.data()!),
          toFirestore: (message, _) => message.toJson(),
        );
    return cloud.orderBy("timestamp", descending: false).snapshots();
  }
}
