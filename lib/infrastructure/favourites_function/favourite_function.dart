import 'package:cookbook/application/add_fav_bloc/bloc/add_favourite_bloc.dart';
import 'package:cookbook/application/fav_screen_bloc/bloc/favourite_screen_bloc.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

List<Recipes> favouriteNotifier = [];

final box = Hive.box<Recipes>('favourites_list');


 addToFavourite(Recipes favourited, BuildContext context) {

  print('added');
  Recipes recipe = Recipes(
      imagePath: favourited.imagePath,
      recipeName: favourited.recipeName,
      cookingTime: favourited.cookingTime,
      catogory: favourited.catogory,
      ingredients: favourited.ingredients,
      extraIngredients: favourited.extraIngredients,
      directions: favourited.directions,
      url: favourited.url);
  
  // int index=0;
  BlocProvider.of<FavouriteScreenBloc>(context).add(AddToFavourite(list: favourited));
  box.put(recipe.recipeName, recipe);
  // favouriteNotifier.value.add(recipe);
  // recipeListNotifier.notifyListeners();
  // print('Added');
  // print(favourited.recipeName);
  
}



removeFavorite(String recipename,BuildContext context)  {
  print(recipename);
  BlocProvider.of<FavouriteScreenBloc>(context).add(RemoveFromFavourite(recipeName: recipename));
   box.delete(recipename);
  // recipeListNotifier.notifyListeners();
  print('deleted');
  // print('box');
 
}


getAllFavourites() {
  favouriteNotifier.clear();
  favouriteNotifier.addAll(box.values);
  // final recipeDB =  Hive.openBox<Recipes>('favourites_list');
  // recipeListNotifier.value.clear();
  // for (var std in recipeDB.values) {
  //   // recipeListNotifier.value.add(std);
  // }
  // recipeListNotifier.notifyListeners();
}
fetchFavs(Recipes recipe,BuildContext context){
  var currentRecipe = recipe.recipeName;
  var isFavourite;
  BlocProvider.of<AddFavouriteBloc>(context).add(FavouritedEvent(recipeName: currentRecipe));
  final favs = favouriteNotifier
          .where((element) => element.recipeName == currentRecipe)
          .isNotEmpty;
          if(favs){
            isFavourite = true;
            print(isFavourite);
          }else{
            isFavourite = false;
          }
          return favs;
}


