import 'package:flutter/material.dart';

Widget textFieldWidget(String hntText,bool hiddenText, myController, [TextInputType? keyboardType]) {
  return SizedBox(
    width: double.maxFinite,
    child: TextFormField(
      keyboardType: keyboardType,
      controller: myController,
      obscureText: hiddenText,
      
      decoration: InputDecoration(
        
        hintText: hntText,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
           style: BorderStyle.solid,
           
          )
          
        )
      ),
  
    ),
  );

}


