
import 'package:cookbook/application/comment_Screen_bloc/bloc/comment_screen_bloc.dart';
import 'package:cookbook/infrastructure/comment_function/comment_functions.dart';
import 'package:cookbook/domain/comment_model/comments_db.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:cookbook/presentation/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReviewScreen extends StatefulWidget {
   const ReviewScreen({required this.recipe, super.key});

  final Recipes recipe;



  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late Box<CommentsData> commentList;

 
  List<CommentsData> commentLists = Hive.box<CommentsData>('comments_db').values.toList();
  late List<CommentsData> reviews = List<CommentsData>.from(commentLists);



  @override
  void initState() {
    print('comment user');
    // TODO: implement initState
    super.initState();
    // loggedUserInfo();
    getAllComments();

  }
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // reviewWidget(),
              Expanded(child: 
                      // final matchingReviews = reviews.where((review) => review.recipeName == widget.recipe.recipeName).toList();

                   BlocBuilder<CommentScreenBloc, CommentScreenState>(
                     builder: (context, state) {
                       final matchingReviews = state.commentList.where((review) => review.recipeName == widget.recipe.recipeName).toList();
                       return ListView.builder(
                                     physics: const BouncingScrollPhysics(),
                                     itemBuilder: (context, index) {
                                       final data = matchingReviews[index];
                                     return commentBubble(data);
                                   },
                                   itemCount: matchingReviews.length,);
                     },
                   )
              //   }  
                
              // )
              ),
              inputSection(widget.recipe,context)
              
            ],
          ),
        ),
      )),
    );
  }
}