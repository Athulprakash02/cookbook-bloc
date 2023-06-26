// import 'package:cookbook/bloc/bloc/add_recipe_bloc.dart';
import 'package:cookbook/application/home_screen_bloc/bloc/home_bloc.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

List<Recipes> recipeList = [];

 addRecipe(Recipes value, BuildContext context)  {
  print('haii');
  final recipeDB =  Hive.box<Recipes>('recipe_list');
  BlocProvider.of<HomeBloc>(context).add(AddRecipe(list: value));
  recipeDB.add(value);
  // value.id = _details;
  getAllRecipe();
  // recipeListNotifier.value.add(value);
  // recipeListNotifier.notifyListeners();
}


Future<void> launchURL(url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

getAllRecipe() {
  print('vilichu');
  final recipeDB =  Hive.box<Recipes>('recipe_list');
  recipeList.clear();
  recipeList.addAll(recipeDB.values);
  // recipeListNotifier.value.clear();
  // for (var std in recipeDB.values) {
  //   // recipeListNotifier.value.add(std);
  // }
  // recipeListNotifier.notifyListeners();
}

deleteAlert(BuildContext context, key) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: const Text(
        'Delete recipe?',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            onPressed: () {
              deleteRecipe(key, context);
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red, fontSize: 20),
            )),
        TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ))
      ],
    ),
  );
}


deleteRecipe(int id,BuildContext context) async{
  final recipeDB =  Hive.box<Recipes>('recipe_list');
  BlocProvider.of<HomeBloc>(context).add(DeleteRecipe(recipeId: id));

  await recipeDB.delete(id);
  getAllRecipe();
  // recipeListNotifier.notifyListeners();
}


 