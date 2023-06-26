part of 'update_screen_bloc.dart';

class UpdateScreenState {
  final List textfields;
  final List controllers;
  final List textKeys;
  final List ingredientsList;

  UpdateScreenState(
      {required this.textfields,
      required this.controllers,
      required this.textKeys,
      required this.ingredientsList});
}

class UpdateScreenInitial extends UpdateScreenState {
  UpdateScreenInitial(
      {required super.textfields,
      required super.controllers,
      required super.textKeys,
      required super.ingredientsList});
}
