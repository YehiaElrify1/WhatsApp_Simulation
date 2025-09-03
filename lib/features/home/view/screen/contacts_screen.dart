import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test1/features/home/data/contact_model.dart';
import 'package:test1/features/home/data/mock_service.dart';
import 'package:test1/features/home/view/screen/chat_screen.dart';
import 'package:test1/features/home/view/widgets/contact_tile.dart';


class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});
  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> with SingleTickerProviderStateMixin {
  late List<ContactModel> contacts;
  late TabController _tabController;
  String query = '';

  @override
  void initState() {
    super.initState();
    contacts = MockService.getContacts();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<ContactModel> get filtered => contacts.where((c) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return c.name.toLowerCase().contains(q) || c.lastMessage.toLowerCase().contains(q);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatsapp', style: GoogleFonts.cairo(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF075E54),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton(itemBuilder: (_) => [
            const PopupMenuItem(value: 'new', child: Text('New group')),
            const PopupMenuItem(value: 'settings', child: Text('Settings')),
          ]),
        ],
        bottom:
        TabBar(
          controller: _tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: Color(0xFF25D366)),
            insets: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // new chat action
        },
        child: const Icon(Icons.chat),
        backgroundColor: const Color(0xFF25D366),
      ),
      body: Column(
        children: [
          // search field like WhatsApp
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // CHATS tab
                ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8), // <<< no white line, just spacing
                  itemBuilder: (context, index) {
                    final c = filtered[index];
                    return ContactTile(
                      contact: c,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatScreen(contact: c)));
                      },
                    );
                  },
                ),

                // STATUS placeholder
                Center(child: Text('Status tab (coming soon)', style: TextStyle(color: Colors.white54))),

                // CALLS placeholder
                Center(child: Text('Calls tab (coming soon)', style: TextStyle(color: Colors.white54))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
