// import 'package:cookbook/bloc/bloc/add_recipe_bloc.dart';
import 'package:cookbook/application/add_fav_bloc/bloc/add_favourite_bloc.dart';
import 'package:cookbook/application/comment_Screen_bloc/bloc/comment_screen_bloc.dart';
import 'package:cookbook/application/fav_screen_bloc/bloc/favourite_screen_bloc.dart';
import 'package:cookbook/application/home_screen_bloc/bloc/home_bloc.dart';
import 'package:cookbook/application/image/bloc/image_bloc.dart';
import 'package:cookbook/application/ingredients_add_bloc/bloc/add_textfeild_bloc.dart';
import 'package:cookbook/application/recent_screen_bloc/bloc/recent_screen_bloc.dart';
import 'package:cookbook/application/search_screen_bloc/bloc/search_bloc.dart';
import 'package:cookbook/application/update/bloc/update_screen_bloc.dart';
import 'package:cookbook/application/update_image_bloc/bloc/update_image_bloc.dart';
import 'package:cookbook/domain/comment_model/comments_db.dart';
import 'package:cookbook/domain/authentication_model/login_model.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:cookbook/presentation/screens/user/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';

const SAVE_KEY_NAME = 'adminLoggedIn';


void main(List<String> args) async {
  
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(LoginDataAdapter().typeId)) {
    Hive.registerAdapter(LoginDataAdapter());
  }
  if (!Hive.isAdapterRegistered(RecipesAdapter().typeId)) {
    Hive.registerAdapter(RecipesAdapter());
  }
  if (!Hive.isAdapterRegistered(CommentsDataAdapter().typeId)) {
    Hive.registerAdapter(CommentsDataAdapter());
  }
  await Hive.openBox<Recipes>('recipe_list');
  await Hive.openBox<CommentsData>('comments_db');
  await Hive.openBox<Recipes>('recently_viewed');
  await Hive.openBox<Recipes>('favourites_list');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => ImageBloc(),
        ),
        BlocProvider(
          create: (context) => AddTextfeildBloc(),
        ),
        BlocProvider(
          create: (context) => AddFavouriteBloc(),
        ),
        BlocProvider(
          create: (context) => FavouriteScreenBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => RecentScreenBloc(),
        ),
        BlocProvider(
          create: (context) => CommentScreenBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateImageBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateScreenBloc(),
        )
      ],
      child: MaterialApp(
        title: 'CookBook',
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: const ScreenSplash(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
