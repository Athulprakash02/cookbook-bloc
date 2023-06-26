part of 'search_bloc.dart';

 class SearchState {
  final List<Recipes> searchList;

  SearchState({required this.searchList});
 }

class SearchInitial extends SearchState {
  SearchInitial({required super.searchList});
}
