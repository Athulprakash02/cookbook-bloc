import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<AddImage>((event, emit) {
      // TODO: implement event handler
      return emit(ImageState(image: event.imagePath));
    });
  }
}
