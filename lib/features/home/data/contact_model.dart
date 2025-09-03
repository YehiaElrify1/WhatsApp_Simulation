class ContactModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final DateTime lastSeen;
  final bool isOnline;
  final int unread;

  ContactModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastSeen,
    required this.isOnline,
    required this.unread,
  });
}
