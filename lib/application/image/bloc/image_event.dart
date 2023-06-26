part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

// ignore: must_be_immutable
class AddImage extends ImageEvent {
  String? imagePath;

  AddImage({required this.imagePath});
}
