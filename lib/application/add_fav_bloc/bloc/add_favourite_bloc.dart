// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'add_favourite_event.dart';
// part 'add_favourite_state.dart';

// class AddFavouriteBloc extends Bloc<AddFavouriteEvent, AddFavouriteState> {
//   AddFavouriteBloc() : super(AddFavouriteInitial(favouriteStatus: {})) {
//     Stream<AddFavouriteState> mapEventToState(AddFavouriteEvent event) async* {
//       if (event is FavouritedEvent) {
//         final recipeName = event.recipeName;
//         final currentStatus = state.favouriteStatus[recipeName] ?? false;
//         final updatedStatus = !currentStatus;
//         final updatedFavouriteStatus = {
//           ...state.favouriteStatus,
//           recipeName: updatedStatus
//         };
//         yield AddFavouriteState(favouriteStatus: updatedFavouriteStatus);
//       }
//     }
//     // on<FavouritedEvent>((event, emit) {
//     //     final recipeName = event.recipeName;

//     //     // TODO: implement event handler

//     //     // final recipeName = event.recipeName;
//     //     // final isFavourite = state.favouriteStatus[recipeName] ?? false;
//     //     // final isFavourite = event.isFavourite;
//     //     // print(isFavourite);
//     //     // isFavourite ?? false;

//     //     // final bool updatedStatus = !isFavourite!;
//     //     // print("uo $updatedStatus");

//     //     // final  updatedFavouriteStatus = updatedStatus;

//     //     return emit(AddFavouriteState(favouriteStatus: !state.favouriteStatus));

//     //   });
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_favourite_event.dart';
part 'add_favourite_state.dart';

class AddFavouriteBloc extends Bloc<AddFavouriteEvent, AddFavouriteState> {
  AddFavouriteBloc() : super(AddFavouriteInitial(favouriteStatus: {})) {
    on<FavouritedEvent>((event, emit) {
      // TODO: implement event handler
      final recipeName = event.recipeName;
      final isFavourite = state.favouriteStatus[recipeName] ?? false;

      final bool updatedStatus = !isFavourite;

      final Map<String,bool> updatedFavouriteStatus ={ ...state.favouriteStatus, recipeName: updatedStatus};

      return emit(AddFavouriteState(favouriteStatus: updatedFavouriteStatus));


    });
  }
}