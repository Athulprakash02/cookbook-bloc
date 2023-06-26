part of 'update_screen_bloc.dart';

@immutable
abstract class UpdateScreenEvent {}

class IncreaseIngredientsTextFeild extends UpdateScreenEvent {
  final List textFields;
  final List controllers;
  final List textKeys;
  final List ingredientsList;

  IncreaseIngredientsTextFeild(
      {required this.textFields,
      required this.controllers,
      required this.textKeys,
      required this.ingredientsList});
}
