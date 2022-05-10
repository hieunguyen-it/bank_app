import 'package:bank/widgets/flutter_bank_login.dart';
import 'package:flutter/material.dart';
import 'package:bank/widgets/flutter_bank_login.dart';

class Ultis {
  static const Color mainThemeColor = Color(0xFF8700C3);
}

class FlutterBankSplash extends StatelessWidget {
  const FlutterBankSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FlutterBankLogin()));
    });

    return Scaffold(
      backgroundColor: Ultis.mainThemeColor,
      body: Stack(
        children: [
          Center(
            child: Icon(
              Icons.savings,
              color: Colors.white,
              size: 60,
            ),
          ),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                  strokeWidth: 8,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
