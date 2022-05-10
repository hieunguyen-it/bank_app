import 'package:bank/widgets/flutter_bank_splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(FlutterBankApp());
}

class FlutterBankApp extends StatelessWidget {
  const FlutterBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: FlutterBankSplash(),
    );
  }
}
