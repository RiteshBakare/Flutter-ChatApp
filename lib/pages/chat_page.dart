import 'package:chat_app/components/chat.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String reciverEmail;
  final String reciverID;
  ChatPage({super.key, required this.reciverEmail, required this.reciverID});

  final TextEditingController _messageController = TextEditingController();

  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
        reciverID,
        _messageController.text.toString(),
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(reciverEmail),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput()
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    //print("SENDER ID: $senderID ");
    //print("RECIVER ID: $reciverID ");
    return StreamBuilder(
      stream: _chatServices.getMSG(reciverID, senderID),
      builder: (context, snapshot) {
        List messages = snapshot.data?.docs ?? [];
        if (snapshot.hasError) {
          return Center(
            child: Text("error: ${snapshot.error} "),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading..."),
          );
        }
        if (messages.isEmpty) {
          return const Center(
            child: Text("Start a Conversation"),
          );
        } else {
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              Message message = messages[index].data();

              bool isCurrentUser =
                  message.senderID == _authService.getCurrentUser()!.uid;

              var alignment =
                  isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

              return Container(
                alignment: alignment,
                child: ChatBackground(
                  message: message.message,
                  isCurrentUser: isCurrentUser,
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildMessageItems(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    print("HELLO: " + data.entries.toString());
    // print("my_data: " + data['messages'].toString());
    return Text(data['messages']);
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              hintText: "Type a message..",
              controller: _messageController,
              isPassword: false,
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                CupertinoIcons.arrow_right,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
