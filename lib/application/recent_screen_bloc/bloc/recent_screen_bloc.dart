
import 'package:cookbook/infrastructure/recents_function/recently_viewed_functions.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'recent_screen_event.dart';
part 'recent_screen_state.dart';

class RecentScreenBloc extends Bloc<RecentScreenEvent, RecentScreenState> {
  RecentScreenBloc() : super(RecentScreenInitial(recentList: recently)) {
    on<AddtoRecent>((event, emit) {
      // TODO: implement event handler
      recently.add(event.recipe);
      return emit(RecentScreenState(recentList: recently));
    });
  }
}
