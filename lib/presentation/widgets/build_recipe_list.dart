import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:cookbook/presentation/screens/user/recipe_screen.dart';
import 'package:cookbook/presentation/widgets/card.dart';
import 'package:flutter/material.dart';

Widget buildCategoryRecipeList(List<Recipes> items, String category) {
  List<Recipes> categoryRecipes =
          items.where((item) => item.catogory == category).toList();
  return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final data = categoryRecipes[index];
          // var isFavourite = fetchFavs(data);
          
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      RecipeScreen(passValue: data, idPass: index),
                ));
              },
              child: userCard(data,context));
        },
        itemCount: categoryRecipes.length,
      );
    
  
}
