import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/core/shared/entities/message.dart';

class ChatMessageUserWidget extends StatelessWidget {
  final Message message;

  const ChatMessageUserWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 06,
              bottom: 12,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              color: Colors.green[800],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  message.text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
