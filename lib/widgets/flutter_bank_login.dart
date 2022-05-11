import 'package:bank/main.dart';
import 'package:bank/widgets/flutter_account_registration.dart';
import 'package:bank/widgets/flutter_bank_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlutterBankLogin extends StatefulWidget {
  const FlutterBankLogin({Key? key}) : super(key: key);

  @override
  State<FlutterBankLogin> createState() => _FlutterBankLoginState();
}

class _FlutterBankLoginState extends State<FlutterBankLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool validateEmailAndPassword() {
    return usernameController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty &&
        Ultis.validateEmail(usernameController.value.text);
  }

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
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 7, color: Ultis.mainThemeColor)),
              child: const Icon(
                Icons.savings,
                color: Ultis.mainThemeColor,
                size: 45,
              ),
            ),
            const SizedBox(height: 30),
            const Text('Welcome to',
                style: TextStyle(color: Colors.grey, fontSize: 15)),
            const Text('Flutter\nSavings Bank',
                style: TextStyle(color: Ultis.mainThemeColor, fontSize: 30)),
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Sign Into Your Bank Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50)),
                      child: TextField(
                          onChanged: (text) {
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.email,
                                  color: Ultis.mainThemeColor),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 20, bottom: 11, top: 11, right: 15),
                              hintText: "Email"),
                          style: const TextStyle(fontSize: 16),
                          controller: usernameController)),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50)),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {});
                        },
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: const InputDecoration(
                            prefixIcon:
                                Icon(Icons.lock, color: Ultis.mainThemeColor),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Password"),
                        controller: passwordController,
                        style: const TextStyle(fontSize: 16),
                      )),

                  // Add Consumer
                  Consumer<LoginService>(builder: (context, lService, child) {
                    String errorMsg = lService.getErrorMessage();

                    if (errorMsg.isEmpty) {
                      return const SizedBox(height: 40);
                    }

                    return Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          const Icon(Icons.warning, color: Colors.red),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(errorMsg,
                                  style: const TextStyle(color: Colors.red)))
                        ]));
                  })
                ],
              ),
            )),
            FlutterBankMainButton(
                label: 'Sign In',
                enabled: validateEmailAndPassword(),
                onTap: () async {
                  var username = usernameController.value.text;
                  var pwd = passwordController.value.text;

                  bool isLoggedIn = await loginService
                      .signInWithEmailAndPassword(username, pwd);

                  if (isLoggedIn) {
                    usernameController.clear();
                    passwordController.clear();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FlutterBankMain()));
                  }
                }),
            const SizedBox(height: 10),
            FlutterBankMainButton(
                label: 'Register',
                icon: Icons.account_circle,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FlutterAccountRegistration())
                  );
                },
                backgroundColor: Ultis.mainThemeColor.withOpacity(0.05),
                iconColor: Ultis.mainThemeColor,
                labelColor: Ultis.mainThemeColor)
          ],
        ),
      ),
    );
  }
}

class FlutterBankMainButton extends StatelessWidget {
  final Function? onTap;
  final String? label;
  final bool? enabled;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? labelColor;

  const FlutterBankMainButton(
      {Key? key,
      this.label,
      this.onTap,
      this.icon,
      this.backgroundColor = Ultis.mainThemeColor,
      this.iconColor = Colors.white,
      this.labelColor = Colors.white,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Material(
            color:
                enabled! ? backgroundColor : backgroundColor!.withOpacity(0.5),
            child: InkWell(
              onTap: enabled!
                  ? () {
                      onTap!();
                    }
                  : null,
              highlightColor: Colors.white.withOpacity(0.2),
              splashColor: Colors.white.withOpacity(0.1),
              child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                            visible: icon != null,
                            child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Icon(icon, color: iconColor, size: 20),
                            )),
                        Text(label!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: labelColor, fontWeight: FontWeight.bold))
                      ])),
            ),
          ),
        )
      ],
    );
  }
}

// Config firebase 2
class LoginService extends ChangeNotifier {
  String _userId = '';
  String _errorMessage = '';

  String getUser() {
    return _userId;
  }

  String getErrorMessage() {
    return _errorMessage;
  }

  void setLogginErrorMessage(String msg) {
    _errorMessage = msg;
    /*
      Model của chúng ta cần sử dụng ChangeNotifie (mixin hoặc extends).
      Khi thay đổi thuộc tính của model, chúng ta sẽ call notifyListeners(), 
      khi đó ChangeNotifierProvider sẽ thông báo cho tất cả Consumer liên quan để rebuild.
    */
    notifyListeners();
  }

  Future<bool> createUserWithEmailAndPassword(String email, String pwd) async {
    try {
      UserCredential userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pwd);

      return true; // or userCredentials != null;

    } on FirebaseAuthException {
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    setLogginErrorMessage('');

    try {
      UserCredential credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      _userId = credentials.user!.uid;

      return true;
    } on FirebaseAuthException catch (ex) {
      setLogginErrorMessage('Error during sign-in: ' + ex.message!);
      return false;
    }
  }
}
