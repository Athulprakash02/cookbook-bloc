part of 'image_bloc.dart';

// @immutable
 class ImageState {
  final String? image;

  ImageState({required this.image});
}

class ImageInitial extends ImageState {
  ImageInitial() : super(image: null);
}
