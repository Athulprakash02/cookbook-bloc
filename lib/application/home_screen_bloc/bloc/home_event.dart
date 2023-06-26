part of 'home_bloc.dart';

// @immutable
abstract class HomeEvent {}

class AddRecipe extends HomeEvent {
  final Recipes list;

  AddRecipe({required this.list});
}

class DeleteRecipe extends HomeEvent {
  final int recipeId;

  DeleteRecipe({required this.recipeId});
}

class UpdateRecipe extends HomeEvent {
  final int index;
  final Recipes value;

  UpdateRecipe({required this.index, required this.value});
}
