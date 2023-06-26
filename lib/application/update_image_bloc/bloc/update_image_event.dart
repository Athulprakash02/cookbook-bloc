part of 'update_image_bloc.dart';

@immutable
abstract class UpdateImageEvent {}
class OnImageChange extends UpdateImageEvent {
  final String imagePath;

  OnImageChange({required this.imagePath});
  
}
