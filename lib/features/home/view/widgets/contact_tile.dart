import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test1/features/home/data/contact_model.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onTap;

  const ContactTile({super.key, required this.contact, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Stack(
        children: [
          Hero(
            tag: 'avatar-${contact.id}',
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.grey[800],
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: contact.avatarUrl,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: Colors.grey[800]),
                  errorWidget: (_, __, ___) => Icon(Icons.person, color: Colors.white24),
                ),
              ),
            ),
          ),
          if (contact.isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: const Color(0xFF25D366), shape: BoxShape.circle, border: Border.all(color: Colors.black87, width: 2)),
              ),
            ),
        ],
      ),
      title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      subtitle: Text(contact.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_formatTime(contact.lastSeen), style: const TextStyle(color: Colors.white60, fontSize: 12)),
          const SizedBox(height: 6),
          contact.unread > 0
              ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF25D366), borderRadius: BorderRadius.circular(12)),
            child: Text('${contact.unread}', style: const TextStyle(color: Colors.black, fontSize: 12)),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  static String _formatTime(DateTime t) {
    final now = DateTime.now();
    final diff = now.difference(t);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${t.day}/${t.month}/${t.year}';
  }
}
