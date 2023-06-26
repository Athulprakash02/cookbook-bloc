part of 'comment_screen_bloc.dart';

 class CommentScreenState {
  final List<CommentsData> commentList;

  CommentScreenState({required this.commentList});
 }

class CommentScreenInitial extends CommentScreenState {
  CommentScreenInitial({required super.commentList});
}
