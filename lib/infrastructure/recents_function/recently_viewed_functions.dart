import 'package:cookbook/application/recent_screen_bloc/bloc/recent_screen_bloc.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

List<Recipes> recently = [];
final box =  Hive.box<Recipes>('recently_viewed');

recentlyViewed(Recipes passvalue,BuildContext context) {
    print('entered recenlyviewed');
    
    Recipes recipe = Recipes(
        imagePath: passvalue.imagePath,
        recipeName: passvalue.recipeName,
        cookingTime: passvalue.cookingTime,
        catogory: passvalue.catogory,
        ingredients: passvalue.ingredients,
        extraIngredients: passvalue.extraIngredients,
        directions: passvalue.directions,
        url: passvalue.url);
   
    int index=0;
    for (var element in box.values) {
      if (recipe.recipeName == element.recipeName) {
        BlocProvider.of<RecentScreenBloc>(context).add(AddtoRecent(recipe: recipe));
        box.deleteAt(index);
        box.add(recipe);
        break;

       
      }
      index++;
    }
    BlocProvider.of<RecentScreenBloc>(context).add(AddtoRecent(recipe: recipe));
     box.add(recipe);
    recents();
  }

recents() {
 
  print(' entered recents');
  
  List<Recipes> recentlyViewedList = box.values.toList();
recently = recentlyViewedList.reversed.toList();
// recently.clear();
 
}

getAllRecents() {
  recently.clear();
  List<Recipes> recentlyViewedList = box.values.toList();
  recently.addAll(recentlyViewedList.reversed);
  // final recipeDB = await Hive.openBox<Recipes>('favourites_list');
 
  
  // recipeListNotifier.value.clear();
  // for (var std in recipeDB.values) {
  //   // recipeListNotifier.value.add(std);
  // }
  // recipeListNotifier.notifyListeners();
}

