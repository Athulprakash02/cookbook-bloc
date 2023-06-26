



import 'package:cookbook/infrastructure/comment_function/comment_functions.dart';
import 'package:cookbook/domain/comment_model/comments_db.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:flutter/material.dart';

final commentController = TextEditingController();
List commentsList = [];



Widget commentBubble(CommentsData reviews){
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
    child: Container(
      width: double.maxFinite,
      
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
        color: Colors.cyan.shade100
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(reviews.userName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.maxFinite,
              child: Text(reviews.comment)),
          ],
        ),
      )
  
    ),
  );
}

Widget inputSection(Recipes recipe,BuildContext context) {
  return Container(
    width: double.infinity,
    height: 80,
    color: const Color.fromARGB(255, 238, 200, 197),
    child: Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: TextField(
            controller: commentController,
            onSubmitted: (value) {},
            decoration: InputDecoration(
                hintText: 'Write review...',
                fillColor: const Color.fromARGB(255, 196, 192, 192),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            onPressed: () {
              onClickedAddComment(commentController.text.trim(), 'user', recipe.recipeName,context);
              print("name: ${recipe.recipeName}");
              commentController.clear();
            },
            backgroundColor: const Color.fromARGB(255, 196, 192, 192),
            child: const Icon(
              Icons.send,
            ),
          ),
        )
      ],
    ),
  );
}


