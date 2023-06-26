import 'package:cookbook/application/fav_screen_bloc/bloc/favourite_screen_bloc.dart';
import 'package:cookbook/infrastructure/favourites_function/favourite_function.dart';
import 'package:cookbook/presentation/widgets/favourites_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    // final box = Hive.box<Recipes>('favourites_list');
    // List<Recipes> favourites = box.values.toList();

    return BlocBuilder<FavouriteScreenBloc, FavouriteScreenState>(
      builder: (context, state) {
        getAllFavourites();
    //     final box = Hive.box<Recipes>('favourites_list');
    // List<Recipes> favourites = box.values.toList();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Favourited recipes'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return favouritesCard(state.fovouriteList[index], context, index);
              },
              itemCount: state.fovouriteList.length,
            ),
          ),
        );
      },
    );
  }
}
