part of 'add_textfeild_bloc.dart';

@immutable
abstract class AddTextfeildEvent {}

class AddIngredientsTextFeild extends AddTextfeildEvent {
  final List textFields;
  final List controllers;
  final List textKeys;
  final List ingredientsList;

  AddIngredientsTextFeild({
    required this.textFields,
    required this.controllers,
    required this.textKeys,
    required this.ingredientsList,
  });
}

class RemoveIngredientsTextField extends AddTextfeildEvent{
  final int index;

  RemoveIngredientsTextField(this.index);

  
}