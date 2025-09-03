import 'package:flutter/material.dart';
import 'package:test1/features/home/data/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMine;
    final radius = Radius.circular(16);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF056162) : const Color(0xFF111827),
          borderRadius: BorderRadius.only(
            topLeft: radius,
            topRight: radius,
            bottomLeft: isMe ? radius : const Radius.circular(4),
            bottomRight: isMe ? const Radius.circular(4) : radius,
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 2, offset: const Offset(0,1))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(color: isMe ? Colors.white : Colors.white70),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.time),
                  style: TextStyle(fontSize: 10, color: isMe ? Colors.white70 : Colors.white54),
                ),
                const SizedBox(width: 6),
                if (isMe)
                  Icon(
                    message.seen ? Icons.done_all : Icons.check,
                    size: 14,
                    color: message.seen ? const Color(0xFF25D366) : Colors.white70,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _formatTime(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
