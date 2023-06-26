part of 'home_bloc.dart';

 class HomeState {
  final List<Recipes> recipeList;

  HomeState({required this.recipeList});
 }

class HomeInitial extends HomeState {
  HomeInitial({required super.recipeList});

}
