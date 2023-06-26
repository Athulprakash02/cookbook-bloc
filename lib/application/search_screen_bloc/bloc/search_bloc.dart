import 'package:bloc/bloc.dart';
import 'package:cookbook/infrastructure/recipe_db_function/db_recipe_functions.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(searchList: recipeList)) {
    on<OnSearch>((event, emit) {
      emit(SearchState(
          searchList: event.recipeList
              .where((element) => element.recipeName
                  .toLowerCase()
                  .contains(event.value.toLowerCase()))
              .toList()));
    });
  }
}
