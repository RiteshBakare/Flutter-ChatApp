import 'package:flutter/material.dart';

class ChatBackground extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBackground(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: isCurrentUser
            ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
        color: isCurrentUser ? Colors.green : Colors.grey.shade500,
      ),
      child: Text(message),
    );
  }
}
