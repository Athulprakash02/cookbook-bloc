import 'package:cookbook/application/home_screen_bloc/bloc/home_bloc.dart';
import 'package:cookbook/infrastructure/recipe_db_function/db_recipe_functions.dart';
import 'package:cookbook/infrastructure/authentication_function/login_functions.dart';
import 'package:cookbook/domain/authentication_model/login_model.dart';
import 'package:cookbook/presentation/screens/managing/add_screen.dart';
import 'package:cookbook/presentation/screens/managing/manage_screen.dart';
import 'package:cookbook/presentation/screens/user/about_screen.dart';
import 'package:cookbook/presentation/screens/user/favourites_screen.dart';
import 'package:cookbook/presentation/screens/user/recent_screen.dart';
import 'package:cookbook/presentation/screens/user/search_screen.dart';
import 'package:cookbook/presentation/screens/user/terms_and_conditions_screen.dart';
import 'package:cookbook/presentation/widgets/build_recipe_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  late LoginData userLogged;

  // late LoginData user;
  // late Box<Recipes> recipeList;

  // late int _selectedOption;
  var categoryItem = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Indian',
    'Italian',
    'Arabian',
    'Chinese'
  ];

  // @override
  @override
  Widget build(BuildContext context) {
    // final userName = getUserName();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        getAllRecipe();
        // recipeList = Hive.box<Recipes>('recipe_list');
        final items = state.recipeList.toList();
        final categories =
            items.map((recipe) => recipe.catogory).toSet().toList();
        return DefaultTabController(
            length: categories.length,
            child: Scaffold(
              // backgroundColor: const Color.fromARGB(234, 255, 255, 255),
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  SearchScreen(),
                        ));
                      },
                      icon: const Icon(Icons.search_outlined)),
                ],
                // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                title: const Text(
                  'CookBook',
                  style: TextStyle(fontSize: 25),
                ),
                centerTitle: true,
              ),

              //Drawer
              drawer: Drawer(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: ListView(
                  children: [
                    const Center(
                      child: DrawerHeader(
                        child: Padding(
                          padding: EdgeInsets.all(35.0),
                          child: Text(
                            'userName',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const FavouritesScreen(),
                                ));
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Favourite recipes',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const RecentsScreen(),
                                ));
                              },
                              icon: const Icon(
                                Icons.history,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Recently Viewed',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ManageScreen(),
                                ));
                              },
                              icon: const Icon(
                                Icons.food_bank_outlined,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Manage recipes',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditions(),
                                ));
                              },
                              icon: const Icon(
                                Icons.list_alt,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AboutScreen(),
                                ));
                              },
                              icon: const Icon(
                                Icons.info_outline,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'About Us',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                          TextButton.icon(
                              onPressed: () {
                                confirmation(context);
                              },
                              icon: const Icon(
                                Icons.logout_rounded,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Logout',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),

              body: SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Theme(
                        data: ThemeData(),
                        child: TabBar(
                          isScrollable: true,
                          physics: const BouncingScrollPhysics(),
                          labelColor: const Color.fromARGB(255, 0, 0, 0),
                          unselectedLabelColor: Colors.cyan,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.black,
                          indicator: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: Colors.cyan.shade300),
                          tabs: categories
                              .map((category) => Tab(
                                    child: Text(
                                      category,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        // height: 2,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TabBarView(
                            children: categories.map(
                              (category) {
                                return buildCategoryRecipeList(items, category);
                                //
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddScreen(),
                  ));
                },
                child: Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.black,
                ),
              ),
            ));
      },
    );
  }
}
