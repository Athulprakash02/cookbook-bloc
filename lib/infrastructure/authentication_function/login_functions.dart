import 'package:cookbook/presentation/screens/user/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

confirmation(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (ctx1) {
        return Material(
          color: Colors.transparent,
          elevation: 5,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(10),
          child: AlertDialog(
            
            backgroundColor: const Color.fromARGB(255, 210, 209, 209),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
            
            content: const Text('Do you want to logout?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx1).pop();
                },
                style: ElevatedButton.styleFrom(
                  
                  shape: const RoundedRectangleBorder(
                    
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                  backgroundColor: Colors.green),
                child: const Text(
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                    'No'),
              ),
              
              ElevatedButton(
                onPressed: () => signout(context),
                style: ElevatedButton.styleFrom(
                  
                  shape: const RoundedRectangleBorder(
                    
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                  backgroundColor: Colors.red),
                child: const Text(
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                    'Yes'),
              ),
            ],
          ),
        );
      },
    );
  }

  signout(BuildContext ctx) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.clear();
    
    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }

  