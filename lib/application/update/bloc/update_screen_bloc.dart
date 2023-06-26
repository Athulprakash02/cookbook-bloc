import 'package:bloc/bloc.dart';
import 'package:cookbook/presentation/screens/managing/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'update_screen_event.dart';
part 'update_screen_state.dart';

class UpdateScreenBloc extends Bloc<UpdateScreenEvent, UpdateScreenState> {
  UpdateScreenBloc()
      : super(UpdateScreenInitial(
            textfields: textfields,
            controllers: controllers,
            textKeys: textKeys,
            ingredientsList: ingredientsList)) {
    on<IncreaseIngredientsTextFeild>((event, emit) {
      // TODO: implement event handler
      controllers.add(TextEditingController());
      textKeys.add(GlobalKey());
      // textfields.add(addIngredients(GlobalKey()));
      ingredientsList.add('');
      return emit(UpdateScreenState(
          textfields: textfields,
          controllers: controllers,
          textKeys: textKeys,
          ingredientsList: ingredientsList));
    });
  }
}
