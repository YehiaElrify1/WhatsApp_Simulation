class MessageModel {
  final String id;
  final String fromId;
  final String toId;
  final String text;
  final DateTime time;
  final bool isMine;
  final bool delivered;
  final bool seen;

  MessageModel({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.text,
    required this.time,
    required this.isMine,
    this.delivered = true,
    this.seen = false,
  });
}
