part of 'comment_screen_bloc.dart';

@immutable
abstract class CommentScreenEvent {}
class AddComment extends CommentScreenEvent{
  final CommentsData comment;

  AddComment({required this.comment});
}
 