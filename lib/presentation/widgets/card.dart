import 'dart:io';

import 'package:cookbook/application/add_fav_bloc/bloc/add_favourite_bloc.dart';
import 'package:cookbook/infrastructure/recipe_db_function/db_recipe_functions.dart';
import 'package:cookbook/infrastructure/favourites_function/favourite_function.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:cookbook/presentation/screens/managing/update_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

final box = Hive.box<Recipes>('favourites_list');

Widget viewCard(BuildContext ctx, Recipes data, int index) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: -15,
            blurRadius: 15,
          )
        ]),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(File(data.imagePath)),
                  // AssetImage(
                  //   data.imagePath,

                  // ),
                  fit: BoxFit.fill),
              color: const Color.fromARGB(255, 5, 4, 2),
              borderRadius: BorderRadius.circular(20)),
          width: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                  right: 15,
                  top: 10,
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(204, 255, 255, 255)),
                  )),
              Positioned(
                right: 10,
                child: IconButton(
                    onPressed: () {
                      deleteAlert(ctx, data.key);
                    },
                    icon: const Icon(Icons.delete)),
              ),
              Positioned(
                  right: 40,
                  child: InkWell(
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(ctx).push(MaterialPageRoute(
                            builder: (context) => UpdateScreen(index: index),
                          ));
                        },
                        icon: const Icon(Icons.edit)),
                    onTap: () {},
                  )),
              Positioned(
                  bottom: 20,
                  left: 30,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(204, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.recipeName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.watch_later_outlined,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(data.cookingTime),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}

Widget userCard(Recipes data, BuildContext context) {
  // var currentRecipe = data.recipeName;
  // final isFavourite = fetchFavs(data, context);

  return BlocBuilder<AddFavouriteBloc, AddFavouriteState>(
    builder: (context, state) {
      
      var currentRecipe = data.recipeName;
      final favouriteStatus = state.favouriteStatus;
      final isFavourite = favouriteStatus[currentRecipe] ?? false;
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: -15,
                blurRadius: 15,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(data.imagePath)), fit: BoxFit.fill),
                  color: const Color.fromARGB(255, 5, 4, 2),
                  borderRadius: BorderRadius.circular(20)),
              width: double.maxFinite,
              child: Stack(
                children: [
                  Positioned(
                      bottom: 20,
                      left: 30,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(204, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.recipeName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.watch_later_outlined,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(data.cookingTime),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(204, 255, 255, 255),
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            onPressed: () {
                              // print(isFavourite);

                              if (isFavourite) {
                                BlocProvider.of<AddFavouriteBloc>(context).add(
                                    FavouritedEvent(recipeName: currentRecipe));
                                removeFavorite(currentRecipe, context);
                              } else {
                                BlocProvider.of<AddFavouriteBloc>(context).add(
                                    FavouritedEvent(recipeName: currentRecipe));
                                addToFavourite(data, context);
                              }
                            },
                            icon: Icon(
                              isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              size: 25,
                              color: Colors.red,
                            )),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
