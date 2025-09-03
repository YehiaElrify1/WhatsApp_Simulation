import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test1/features/home/view/screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WhatsappSimApp());
}

class WhatsappSimApp extends StatelessWidget {
  const WhatsappSimApp({super.key});

  static const Color whatsappGreen = Color(0xFF128C7E);
  static const Color backgroundDark = Color(0xFF0B1417); // deep background
  static const Color cardDark = Color(0xFF1E2A2B); // cards

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData.dark();
    final ThemeData darkTheme = base.copyWith(
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: whatsappGreen,
      colorScheme: base.colorScheme.copyWith(primary: whatsappGreen, secondary: whatsappGreen),
      appBarTheme: const AppBarTheme(
        backgroundColor: whatsappGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: whatsappGreen),
      textTheme: GoogleFonts.cairoTextTheme(base.textTheme).apply(bodyColor: Colors.white),
      cardColor: cardDark,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF12191A),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
        hintStyle: TextStyle(color: Colors.white60),
      ),
    );

    return MaterialApp(
      title: 'Whatsapp',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const SplashScreen(),
    );
  }
}
