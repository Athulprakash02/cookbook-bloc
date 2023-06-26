import 'package:bloc/bloc.dart';
import 'package:cookbook/infrastructure/favourites_function/favourite_function.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:meta/meta.dart';

part 'favourite_screen_event.dart';
part 'favourite_screen_state.dart';

class FavouriteScreenBloc extends Bloc<FavouriteScreenEvent, FavouriteScreenState> {
  FavouriteScreenBloc() : super(FavouriteScreenInitial(fovouriteList: favouriteNotifier)) {
    on<AddToFavourite>((event, emit) {
      
      favouriteNotifier.add(event.list);
      return emit(FavouriteScreenState(fovouriteList: favouriteNotifier)); 
    });

    on<RemoveFromFavourite>((event, emit) {
      favouriteNotifier.remove(event.recipeName);
      return emit(FavouriteScreenState(fovouriteList: favouriteNotifier));
    });
  }
}
