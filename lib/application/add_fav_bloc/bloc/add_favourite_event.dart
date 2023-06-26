// part of 'add_favourite_bloc.dart';

// @immutable
// abstract class AddFavouriteEvent {}

// class FavouritedEvent extends AddFavouriteEvent  {
//   final String recipeName;
//   // final bool? isFavourite;

//   FavouritedEvent({required this.recipeName});
  
// }

part of 'add_favourite_bloc.dart';

@immutable
abstract class AddFavouriteEvent {}

class FavouritedEvent extends AddFavouriteEvent  {
  final String recipeName;

  FavouritedEvent({required this.recipeName});

}