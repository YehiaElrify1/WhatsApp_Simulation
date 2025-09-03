import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test1/features/home/data/contact_model.dart';
import 'package:test1/features/home/data/message_model.dart';
import 'package:test1/features/home/data/mock_service.dart';
import 'package:test1/features/home/view/widgets/chat_bubble.dart';


class ChatScreen extends StatefulWidget {
  final ContactModel contact;
  const ChatScreen({super.key, required this.contact});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<MessageModel> messages;
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    messages = MockService.getMessagesFor(widget.contact.id);
  }

  void _sendMessage() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    final msg = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fromId: MockService.myId,
      toId: widget.contact.id,
      text: text,
      time: DateTime.now(),
      isMine: true,
      seen: false,
    );
    setState(() {
      messages.insert(0, msg); // newest first in list view reversed
      _ctrl.clear();
    });
    // scroll to bottom (since we'll use reversed ListView, animate to 0)
    _scroll.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.contact;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back),
            ),
            Hero(
              tag: 'avatar-${c.id}',
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: c.avatarUrl,
                    width: 38,
                    height: 38,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c.name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(c.isOnline ? 'متصل الآن' : 'آخر ظهور ${_lastSeen(c.lastSeen)}', style: TextStyle(fontSize: 12)),
            ]),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              reverse: true, // so newest messages at bottom visually
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ChatBubble(message: msg);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالة',
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        fillColor: Colors.grey[100],
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _lastSeen(DateTime t) {
    final now = DateTime.now();
    final diff = now.difference(t);
    if (diff.inMinutes < 60) return '${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return '${diff.inHours} ساعة';
    return '${t.day}/${t.month}/${t.year}';
  }
}
