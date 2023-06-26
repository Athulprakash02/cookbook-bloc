import 'package:cookbook/core/constants/constants.dart';
import 'package:cookbook/domain/authentication_model/login_model.dart';
import 'package:cookbook/presentation/screens/user/signup_screen.dart';
import 'package:cookbook/presentation/screens/user/home_screen.dart';
import 'package:cookbook/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginData loggedPerson;
  final _email = TextEditingController();
  final _password = TextEditingController();

  // ignore: null_check_always_fails
  String get emailLoggedIn => null!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.openBox<LoginData>('login_db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cookbooklogo.png',
                  width: 150,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5,
                          spreadRadius: 7,
                          color: Colors.grey.withOpacity(1),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                              child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: textFieldWidget('abc@gmail.com', false,
                                _email, TextInputType.emailAddress),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: textFieldWidget('Password', true, _password,
                                TextInputType.visiblePassword),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Forget Password?',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 9, 79, 136)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 8, 25, 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () {
                                  if (_email.text.trim().isNotEmpty &&
                                      _password.text.trim().isNotEmpty) {
                                    if (_email.text.trim() ==
                                            'testapp@gmail.com' &&
                                        _password.text.trim() == 'demo') {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ),
                                          (route) => false);
                                    }
                                    onLoginClick();
                                    // getUser();
                                    saveLogin();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                               HomeScreen(),
                                        ),
                                        (route) => false);
                                    // saveLogin();
                                  } else {
                                    validCheck();
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                          ),
                          // Center(
                          //   child: TextButton(
                          //     onPressed: () {
                          //       Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => const AdminLogin(),
                          //       ));
                          //     },
                          //     child: const Text(
                          //       'Login as admin',
                          //       style: TextStyle(
                          //           color: Color.fromARGB(255, 71, 70, 70)),
                          //     ),
                          //   ),
                          // ),
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 18),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ));
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 84, 148)),
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }

  bool onLoginClick() {
    final email = _email.text.trim();
    final passWord = _password.text.trim();

    final userLogin = Hive.box<LoginData>('login_db');
    loggedPerson = userLogin.values.firstWhere(
      (element) => element.email == email && element.password == passWord,
      orElse: () => invalid(),
    );
    // user = loggedPerson;

    return true;
  }

  invalid() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: const Text(
          'Invalid Email and Password',
          style: TextStyle(fontSize: 18),
        )));
  }

  validCheck() {
    var _errorMessage = '';

    if (_email.text.isEmpty && _password.text.isEmpty) {
      _errorMessage = 'Please fill all fields';
    } else if (_email.text.isEmpty) {
      _errorMessage = 'Please add email adress!!';
    } else if (_password.text.isEmpty) {
      _errorMessage = 'Please Enter a Password!!';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          _errorMessage,
          style: const TextStyle(fontSize: 18),
        )));
  }

  saveLogin() async {
    // print('object');
    final email = _email.text.toString().trim();
    // //  user = await getUser(email);
    //  print('return name = user');
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(userLoggedIn, true);
    await sharedPref.setString(emailLoggedIn, email);
    // await SharedPrefs.storeUserName(email);
    // print(email);
  }
}
