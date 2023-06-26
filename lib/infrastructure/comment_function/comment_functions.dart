
import 'package:cookbook/application/comment_Screen_bloc/bloc/comment_screen_bloc.dart';
import 'package:cookbook/domain/comment_model/comments_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

List<CommentsData> commentsList = [];

addComment(CommentsData value, BuildContext context) {
  final commentsDB = Hive.box<CommentsData>('comments_db');
  BlocProvider.of<CommentScreenBloc>(context).add(AddComment(comment: value));

 commentsDB.add(value);
  
  getAllComments();
  // commentsListNotifier.value.add(value);
  // commentsListNotifier.notifyListeners();
}

getAllComments()  {
  final commentsDB =  Hive.box<CommentsData>('comments_db');
  commentsList.clear();
  commentsList.addAll(commentsDB.values);
//   commentsListNotifier.value.clear();
//   commentsListNotifier.value.addAll(commentsDB.values);
//   commentsListNotifier.notifyListeners();
}

onClickedAddComment(String commentTextController, username, recipename,BuildContext context) {
  final userName = username;
  final recipeName = recipename;

  print('clicked');

  final comment = CommentsData(
      userName: userName,
      recipeName: recipeName,
      comment: commentTextController);
  addComment(comment,context);

  // // comments.clear();
  // commentsList.add(commentController.text);
}
