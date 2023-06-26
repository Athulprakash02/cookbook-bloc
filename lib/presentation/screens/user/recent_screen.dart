import 'package:cookbook/application/recent_screen_bloc/bloc/recent_screen_bloc.dart';
import 'package:cookbook/infrastructure/recents_function/recently_viewed_functions.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:cookbook/presentation/widgets/recent_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentsScreen extends StatelessWidget {
  const RecentsScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    List<Recipes> recent = recently.toSet().toList();

    return BlocBuilder<RecentScreenBloc, RecentScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recently viewed'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return recentCard(recent[index], context, index);
              },
              itemCount: recent.length,
            ),
          ),
        );
      },
    );
  }
}
