part of 'update_image_bloc.dart';

 class UpdateImageState {
  String? imagePath;

  UpdateImageState(this.imagePath);
 }


class UpdateImageInitial extends UpdateImageState {
  UpdateImageInitial() : super('');
}
