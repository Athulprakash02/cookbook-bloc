import 'dart:io';

import 'package:cookbook/infrastructure/recipe_db_function/db_recipe_functions.dart';
import 'package:cookbook/infrastructure/recents_function/recently_viewed_functions.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:cookbook/presentation/screens/user/comment_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RecipeScreen extends StatefulWidget {
  RecipeScreen({Key? key, required this.passValue, required this.idPass})
      : super(key: key);

  Recipes passValue;
  final int idPass;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  List<String> ingredientsList = [];

  @override
  void initState() {
    
    // TODO: implement initState

    super.initState();
    recentlyViewed(widget.passValue,context);
    ingredientsList.add(widget.passValue.ingredients);
    ingredientsList.addAll(widget.passValue.extraIngredients);
    // print(ingredientsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(widget.passValue.imagePath)),
                          fit: BoxFit.cover)),
                )),
            Positioned(
                top: 30,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.cyan.shade100,
                  radius: 25,
                  child: IconButton(
                    iconSize: 35,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_sharp),
                    color: Colors.black,
                  ),
                )),
            Positioned(
                top: 30,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.cyan.shade100,
                  radius: 25,
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ReviewScreen(recipe: widget.passValue),
                      ));
                    },
                    icon: const Icon(Icons.reviews_outlined),
                    color: Colors.black,
                  ),
                )),
            Positioned(
                top: 90,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.cyan.shade100,
                  radius: 25,
                  child: IconButton(
                      iconSize: 35,
                      onPressed: () {
                        launchURL(widget.passValue.url);
                       
                      },
                      icon: const Icon(
                        Icons.play_circle_fill,
                        color: Colors.red,
                      )),
                )),
            Positioned(
                top: 320,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade100,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Column(
                      children: [
                        Text(
                          widget.passValue.recipeName,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.watch_later_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(widget.passValue.cookingTime),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  const Center(
                                    child: Text(
                                      'ingredients',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    // width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "\u25CF ${ingredientsList.join('\n\u25CF ')}",
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                  ),

                                  const Divider(
                                    thickness: 2,
                                    height: 20,
                                  ),

                                  const Center(
                                    child: Text(
                                      'Directions',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.passValue.directions,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

 
}
