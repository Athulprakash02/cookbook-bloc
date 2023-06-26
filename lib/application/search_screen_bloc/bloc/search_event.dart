part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnSearch extends SearchEvent {
  final List<Recipes> recipeList;
  final String value;

  OnSearch({
    required this.recipeList,
    required this.value,
  });
}
