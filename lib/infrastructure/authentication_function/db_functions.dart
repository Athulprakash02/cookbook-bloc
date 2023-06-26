// import 'package:cookbook/db/functions/shared_prefs.dart';
import 'package:cookbook/domain/authentication_model/login_model.dart';
// import 'package:cookbook/screens/splash_screen.dart';
import 'package:cookbook/presentation/screens/user/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future signUp(LoginData value) async {
  final signed = await Hive.openBox<LoginData>('login_db');
  final _details = await signed.add(value);
  value.id = _details;
}

onClickSignUp(_email, _name, _password, _confirmPassword, context) {
  

  final userLogin = LoginData(
      fullName: _name,
      email: _email,
      password: _password,
      confirmPassword: _confirmPassword);

  signUp(userLogin);

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false);
} 

Future exists(String mailId, ctx, _name, _password, _confirmPassword) async {
  final emailBox = await Hive.openBox<LoginData>('login_db');
  final emails = emailBox.values.toList();

  final emailExists =
      emails.where((element) => element.email == mailId).isNotEmpty;

  if (emailExists) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: const Text(
          'Email already exists',
          style: TextStyle(fontSize: 18),
        )));
  } else {
    onClickSignUp(mailId, _name, _password, _confirmPassword, ctx);
  }
}


//  Future<String> getUserName() async{
//   print('entered');
    
    
    
//     final userName = await SharedPrefs.getUserName();

   
//       return userName!;
      
   
//   }


  loggedUserInfo() async {
    print('hello');

    final prefs = await  SharedPreferences.getInstance();

    final getName = prefs.getString('emailLoggedIn');
    print(getName);
    final user = getName ?? 'user';
    print(user);

    
  }






