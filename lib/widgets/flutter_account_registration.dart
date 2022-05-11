import 'package:bank/widgets/flutter_bank_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flutter_bank_login.dart';

class FlutterAccountRegistration extends StatefulWidget {
  const FlutterAccountRegistration({Key? key}) : super(key: key);

  @override
  State<FlutterAccountRegistration> createState() =>
      _FlutterAccountRegistrationState();
}

class _FlutterAccountRegistrationState
    extends State<FlutterAccountRegistration> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Ultis.mainThemeColor),
          backgroundColor: Colors.transparent,
          title: const Icon(
            Icons.savings,
            color: Ultis.mainThemeColor,
            size: 40,
          ),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Container(
                      margin: EdgeInsets.only(bottom: 40.0),
                      child: const Text(
                        'Create New Account',
                        style: TextStyle(
                            color: Ultis.mainThemeColor, fontSize: 20),
                      ),
                    ),
                    // email field
                    Ultis.generateInputField(
                        'Email', Icons.email, usernameController, false,
                        (text) {
                      setState(() {});
                    }),
                    // password field
                    Ultis.generateInputField(
                        'Password', Icons.lock, passwordController, true,
                        (text) {
                      setState(() {});
                    }),
                    // password confirmation field
                    Ultis.generateInputField('Confirm Password', Icons.lock,
                        confirmPasswordController, true, (text) {
                      setState(() {});
                    }),
                  ],
                )),
                FlutterBankMainButton(
                    label: 'Register',
                    enabled: validateFormFields(),
                    onTap: () async {
                      String username = usernameController.value.text;
                      String pwd = passwordController.value.text;

                      bool accountCreated = await loginService
                          .createUserWithEmailAndPassword(username, pwd);

                      if (accountCreated) {
                        Navigator.of(context).pop();
                      }
                    })
              ],
            )));
  }

  bool validateFormFields() {
    return Ultis.validateEmail(usernameController.value.text) &&
        usernameController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty &&
        confirmPasswordController.value.text.isNotEmpty &&
        (passwordController.value.text == confirmPasswordController.value.text);
  }
}
