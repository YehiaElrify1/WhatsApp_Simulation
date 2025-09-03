import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'contacts_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ContactsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const whatsappGreen = Color(0xFF25D366);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF062A27), Color(0xFF0B3B37)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              // logo
              FaIcon(FontAwesomeIcons.whatsapp, size: 72, color: whatsappGreen),

              SizedBox(height: 12),
              Text('Whatsapp',
                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Developed by: Yehia Elrify', style: TextStyle(color: Colors.white70)),
              SizedBox(height: 24),

              // SINGLE loading indicator only
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(whatsappGreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
