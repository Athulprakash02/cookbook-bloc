part of 'favourite_screen_bloc.dart';

@immutable
abstract class FavouriteScreenEvent {}

class AddToFavourite extends FavouriteScreenEvent {
  final Recipes list;

  AddToFavourite({required this.list});
}

class RemoveFromFavourite extends FavouriteScreenEvent {
  final String recipeName;

  RemoveFromFavourite({required this.recipeName});


}
