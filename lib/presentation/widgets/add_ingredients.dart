import 'package:flutter/material.dart';


Widget recipeText(TextEditingController myController,hintText, [int? maxlines]){
  return TextField(
                controller: myController,
                maxLines: maxlines,
                  decoration: InputDecoration(
                    
                      hintText: hintText,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))));
}

Widget szdBox(){
  return SizedBox(
    height: 20,
  );
}