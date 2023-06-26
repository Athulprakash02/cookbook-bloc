part of 'recent_screen_bloc.dart';


abstract class RecentScreenEvent {}

class AddtoRecent extends RecentScreenEvent {
  final Recipes recipe;

  AddtoRecent({required this.recipe});
  
}
