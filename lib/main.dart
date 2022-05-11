import 'package:bank/widgets/flutter_account_registration.dart';
import 'package:bank/widgets/flutter_bank_login.dart';
import 'package:bank/widgets/flutter_bank_splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  // Config firebase 1
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAkNGTtugPcpdPPrZoQ7iqCV_ZA4m3Wz50",
          authDomain: "flutter-bank-app-ef6c5.firebaseapp.com",
          projectId: "flutter-bank-app-ef6c5",
          storageBucket: "flutter-bank-app-ef6c5.appspot.com",
          messagingSenderId: "661395221413",
          appId: "1:661395221413:web:e14f392d258f634c8a964c"));

  runApp(MultiProvider(
    // add Provider
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginService(),
      )
    ],
    child: FlutterBankApp(),
  ));
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

class FlutterBankMain extends StatelessWidget {
  const FlutterBankMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('main page')),
    );
  }
}
