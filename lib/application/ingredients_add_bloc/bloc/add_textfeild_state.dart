part of 'add_textfeild_bloc.dart';

class AddTextfeildState {
  final List textFields;
  final List controllers;
  final List textKeys;
  final List ingredientsList;
  // final int index;
  // final BuildContext? context;

  AddTextfeildState(
      {required this.textFields,
      required this.controllers,
      required this.textKeys,
      required this.ingredientsList,
      // required this.index
      // this.context
       });
}

class AddTextfeildInitial extends AddTextfeildState {
  AddTextfeildInitial()
      : super(
            controllers: controllers,
            ingredientsList: ingredientsList,
            textFields: textfields,
            textKeys: textKeys,
            // index: 0
            );
}
