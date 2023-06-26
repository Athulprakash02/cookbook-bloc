// import 'package:cookbook/db/functions/db_functions.dart';

import 'package:cookbook/infrastructure/authentication_function/db_functions.dart';
import 'package:cookbook/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  late Box box1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBox();
  }

  void createBox() async {
    box1 = await Hive.openBox('login_db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Column(
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
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                                child: Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            )),
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Full Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: textFieldWidget(
                                    'abc', false, _name, TextInputType.name)),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: textFieldWidget('abc@gmail.com', false,
                                    _email, TextInputType.emailAddress)),
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
                                child: textFieldWidget('password', true,
                                    _password, TextInputType.text)),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Confirm Password',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: textFieldWidget(
                                  'Password',
                                  true,
                                  _confirmPassword,
                                  TextInputType.visiblePassword),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 8, 25, 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () {
                                    if (_email.text.isNotEmpty &&
                                        _name.text.isNotEmpty &&
                                        _password.text.isNotEmpty &&
                                        _confirmPassword.text.isNotEmpty &&
                                        (_password.text.trim() ==
                                            _confirmPassword.text.trim())) {
                                      exists(
                                          _email.text,
                                          context,
                                          _name.text,
                                          _password.text,
                                          _confirmPassword.text);
                                    } else {
                                      validCheck();
                                      
                                    }
                                    // validCheck();
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                            )
                          ]),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  
  validCheck() async {
    final pass = _password.text.trim();
    final conf = _confirmPassword.text.trim();
    var _errorMessage = '';

    if (_email.text.isEmpty &&
        _name.text.isEmpty &&
        _password.text.isEmpty &&
        _confirmPassword.text.isEmpty) {
      _errorMessage = 'Please fill all fields';
    } else if (_name.text.isEmpty) {
      _errorMessage = 'Please add username';
    } else if (_email.text.isEmpty) {
      _errorMessage = 'Please add email adress!!';
    } else if (_password.text.isEmpty) {
      _errorMessage = 'Please Enter a Password!!';
    } else if (_confirmPassword.text.isEmpty) {
      _errorMessage = 're-enter Password';
    }

    if (pass != conf) {
      _errorMessage = 'Enter same password to continue';
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
}
