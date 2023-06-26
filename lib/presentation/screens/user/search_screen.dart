import 'package:cookbook/application/search_screen_bloc/bloc/search_bloc.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:cookbook/presentation/screens/user/recipe_screen.dart';
import 'package:cookbook/presentation/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  // late int _selectedOption;
  final _searchController = TextEditingController();

  List<Recipes> recipeList = Hive.box<Recipes>('recipe_list').values.toList();

  late List<Recipes> recipes = List<Recipes>.from(recipeList);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchBloc>(context)
        .add(OnSearch(recipeList: recipeList, value: ''));
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        controller: _searchController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  clearText();
                                },
                                icon: const Icon(Icons.clear)),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            hintText: 'Search Recipe...'),
                        onChanged: (value) =>
                            BlocProvider.of<SearchBloc>(context).add(
                                OnSearch(recipeList: recipeList, value: value)),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     print('object');
                    //   },
                    //   icon: const Icon(Icons.filter_alt_outlined),
                    //   iconSize: 35,
                    // )
                  ],
                ),
              ),
              Expanded(child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return recipeList.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.searchList.length,
                          itemBuilder: (context, index) {
                            // final data = state.searchList[index];
                            // var isFavourite = fetchFavs(data);

                            return GestureDetector(
                                onTap: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RecipeScreen(
                                        passValue: state.searchList[index],
                                        idPass: index),
                                  ));
                                },
                                child: userCard(state.searchList[index],context));
                          },
                        )
                      : const Center(
                          child: Text("Couldn't find results"),
                        );
                },
              ))
            ],
          ),
        )),
      ),
    );
  }

  // void _recipeSearch(String recipeName) {
  void clearText() {
    _searchController.clear();
  }
}
