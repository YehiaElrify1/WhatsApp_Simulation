import 'package:test1/features/home/data/contact_model.dart';
import 'package:test1/features/home/data/message_model.dart';


class MockService {
  static const String myId = 'user_yahia';

  static List<ContactModel> getContacts() {
    final now = DateTime.now();
    final names = [
      'Yahia Elrify',
      'محمد أحمد',
      'أحمد حسن',
      'سارة علي',
      'نور محمد',
      'علي محمود',
      'محمود سيد',
      'ليلى مصطفى'
    ];

    return List.generate(names.length, (i) {
      final name = names[i];
      final avatar = 'https://picsum.photos/seed/${Uri.encodeComponent(name)}/200/200';
      return ContactModel(
        id: 'c_$i',
        name: name,
        avatarUrl: avatar,
        lastMessage: i % 3 == 0 ? 'السلام عليكم' : (i % 3 == 1 ? 'تمام شكراً' : 'تمام هنتكلم بعدين'),
        lastSeen: now.subtract(Duration(minutes: i * 7 + 3)),
        isOnline: i % 4 == 0,
        unread: i == 2 ? 3 : (i == 0 ? 1 : 0),
      );
    });
  }

  static List<MessageModel> getMessagesFor(String contactId) {
    final now = DateTime.now();
    final messages = <MessageModel>[
      MessageModel(
        id: 'm1',
        fromId: myId,
        toId: contactId,
        text: 'أزيك يا صاحبي؟',
        time: now.subtract(Duration(minutes: 30)),
        isMine: true,
        delivered: true,
        seen: true,
      ),
      MessageModel(
        id: 'm2',
        fromId: contactId,
        toId: myId,
        text: 'الحمد لله، إنت أخبارك إيه؟',
        time: now.subtract(Duration(minutes: 28)),
        isMine: false,
      ),
      MessageModel(
        id: 'm3',
        fromId: myId,
        toId: contactId,
        text: 'شغال على مشروع Flutter دلوقتي',
        time: now.subtract(Duration(minutes: 4)),
        isMine: true,
        seen: false,
      ),
    ];

    // add some more sample chatter
    for (int i = 0; i < 4; i++) {
      messages.add(MessageModel(
        id: 'm_extra_$i',
        fromId: i.isEven ? myId : contactId,
        toId: i.isEven ? contactId : myId,
        text: i.isEven ? 'رسالة رقم $i' : 'رد على رسالة $i',
        time: now.subtract(Duration(minutes: i * 3 + 1)),
        isMine: i.isEven,
      ));
    }

    return messages;
  }
}
