import 'package:bloc/bloc.dart';
import 'package:cookbook/presentation/screens/managing/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_textfeild_event.dart';
part 'add_textfeild_state.dart';

class AddTextfeildBloc extends Bloc<AddTextfeildEvent, AddTextfeildState> {
  AddTextfeildBloc() : super(AddTextfeildInitial()) {
    on<AddIngredientsTextFeild>((event, emit) {
      print('ivde vann');
      // // TODO: implement event handler
      // GlobalKey key = ;
      controllers.add(TextEditingController());
      textKeys.add(GlobalKey());
      print(textKeys.length);
      textfields.add(addIngredients(GlobalKey()));
      print("uhbshb${textfields.length}");
      // ingredientsList.clear();
      ingredientsList.add('');
      print(ingredientsList);

      return emit(AddTextfeildState(
          textFields: textfields,
          controllers: controllers,
          textKeys: textKeys,
          ingredientsList: ingredientsList));
    });

    on<RemoveIngredientsTextField>((event, emit) {
      final updatedTextFeilds = state.textFields.toList();
      final updatedControllers = state.controllers.toList();
      final updatedTextKeys = state.textKeys.toList();
      final updatedIngredientsList = state.ingredientsList.toList();

      if (event.index >= 0 && event.index < updatedTextFeilds.length) {
        updatedTextFeilds.removeAt(event.index);
        updatedControllers.removeAt(event.index);
        updatedTextKeys.removeAt(event.index);
        updatedIngredientsList.removeAt(event.index);
      }

      emit(AddTextfeildState(
          textFields: updatedTextFeilds,
          controllers: updatedControllers,
          textKeys: updatedTextKeys,
          ingredientsList: updatedIngredientsList));
    });
  }
}
