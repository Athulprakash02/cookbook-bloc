import 'dart:io';

import 'package:cookbook/application/image/bloc/image_bloc.dart';
import 'package:cookbook/application/ingredients_add_bloc/bloc/add_textfeild_bloc.dart';
import 'package:cookbook/infrastructure/recipe_db_function/db_recipe_functions.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
// import 'package:cookbook/screens/admin/manage_screen.dart';
// import 'package:cookbook/screens/admin/update_screen.dart';
import 'package:cookbook/presentation/screens/user/home_screen.dart';
import 'package:cookbook/presentation/widgets/add_ingredients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

final List<GlobalKey> textKeys = [];
final List<Widget> textfields = [];
final List<TextEditingController> controllers = [];
final List<String> ingredientsList = [];

class AddScreen extends StatefulWidget {
   AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // List<GlobalKey> textKeys = [];
  final TextEditingController _recipeNameController = TextEditingController();

  final TextEditingController _durationController = TextEditingController();

  final TextEditingController _directionController = TextEditingController();

  final TextEditingController _ingredientsController = TextEditingController();

  final TextEditingController _youtubeLink = TextEditingController();

  late String category;

  String? imagePath;

  String dropDownValue = 'Category';

  // var isVisible = true;
  var items = [
    'Category',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Indian',
    'Italian',
    'Arabian',
    'Chinese'
  ];

  imagePick(BuildContext context) async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      BlocProvider.of<ImageBloc>(context)
          .add(AddImage(imagePath: imagePicked.path));
      // setState(() {
      //   imagePath = imagePicked.path;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    textfields.clear();
    textKeys.clear();
    controllers.clear();
    ingredientsList.clear();

    print('build');
    return Scaffold(
      backgroundColor: const Color.fromARGB(238, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Add Recipe'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, state) {
                    print('bloc');
                    imagePath = state.image;
                    return Stack(
                      children: [
                        Container(
                          width: 200,
                          height: 120,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  opacity: imagePath == null ? 0 : 1,
                                  image: imagePath == null
                                      ? const AssetImage(
                                              'assets/images/cookbooklogo.png')
                                          as ImageProvider
                                      : FileImage(File(imagePath!)))),
                          child: Visibility(
                            visible: imagePath == null,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () => imagePick(context),
                                    icon: const Icon(
                                      Icons.add_box_outlined,
                                      size: 30,
                                    )),
                                const Text(
                                  'Tap to add Recipe Image',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              szdBox(),
              recipeText(_recipeNameController, 'Recipe name', 1),
              szdBox(),
              recipeText(_durationController, 'Cooking time', 1),
              szdBox(),
              SizedBox(
                height: 55,
                width: double.maxFinite,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  value: 'Category',
                  items: items
                      .map(
                        (String items) => DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      dropDownValue = value!;
                      category = value;
                    });
                  },
                ),
              ),
              szdBox(),
              BlocBuilder<AddTextfeildBloc, AddTextfeildState>(
                builder: (context, state) {
                  
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: recipeText(_ingredientsController,
                                  'Add ingredients', 1)),
                          IconButton(
                              iconSize: 35,
                              onPressed: () => addTextField(context),
                              icon: const Icon(Icons.add_box_outlined))
                        ],
                      ),
                      ...textfields
                    ],
                  );
                },
              ),
              szdBox(),
              recipeText(_directionController, 'Directions for Cook', 10),
              const SizedBox(
                height: 20,
              ),
              recipeText(_youtubeLink, 'Link to the video', 1),
              szdBox(),
              ElevatedButton.icon(
                  onPressed: () {
                    if (imagePath != null &&
                        _recipeNameController.text.isNotEmpty &&
                        _durationController.text.isNotEmpty &&
                        dropDownValue != 'Category' &&
                        _ingredientsController.text.isNotEmpty &&
                        _directionController.text.isNotEmpty &&
                        _youtubeLink.text.isNotEmpty) {
                      onAddButtonClicked(context);
                      addedSuccesully(context);
                    } else {
                      validCheck(context);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'))
            ],
          ),
        ),
      ])),
    );
  }

  addTextField(BuildContext context) {
    print('function keri');
    BlocProvider.of<AddTextfeildBloc>(context).add(AddIngredientsTextFeild(
      textFields: textfields,
      controllers: controllers,
      textKeys: textKeys,
      ingredientsList: ingredientsList,
    ));
    textfields.add(addIngredients(GlobalKey(),context));
    ingredientsList.add('');
    print("vannu =${textKeys.length}");
    
  }

  onAddButtonClicked(BuildContext context) {
    print('Clicked');
    print(ingredientsList);

    final recipeName = _recipeNameController.text.trim();
    final duration = _durationController.text.trim();
    final category = dropDownValue;
    final ingredients = _ingredientsController.text.trim();
    final extraIngredients = ingredientsList;
    final direction = _directionController.text.trim();
    final link = _youtubeLink.text.trim();

    if (recipeName.isEmpty ||
        duration.isEmpty ||
        ingredients.isEmpty ||
        direction.isEmpty ||
        link.isEmpty) {
      print('returned');
      return;
    }
    print('reached');
    print(category);
    final recipeDetails = Recipes(
        imagePath: imagePath!,
        recipeName: recipeName,
        cookingTime: duration,
        catogory: category,
        ingredients: ingredients,
        extraIngredients: extraIngredients,
        directions: direction,
        url: link);
    print(ingredientsList);

    addRecipe(recipeDetails, context);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false);
  }

  validCheck(BuildContext context) {
    var errorMessage = '';
    if (imagePath == null &&
        _recipeNameController.text.isEmpty &&
        _durationController.text.isEmpty &&
        _ingredientsController.text.isEmpty &&
        _directionController.text.isEmpty &&
        _youtubeLink.text.isEmpty) {
      errorMessage = 'Please fill all the fields';
    } else if (imagePath == null) {
      errorMessage = 'Please add image';
    } else if (_recipeNameController.text.isEmpty) {
      errorMessage = 'Please add Recipe name';
    } else if (_durationController.text.isEmpty) {
      errorMessage = 'Please add cooking time';
    } else if (_ingredientsController.text.isEmpty) {
      errorMessage = 'Please add ingredients';
    } else if (_directionController.text.isEmpty) {
      errorMessage = 'Please add directions';
    } else if (_youtubeLink.text.isEmpty) {
      errorMessage = 'Please add any link of making video';
    } else if (dropDownValue == 'Category') {
      errorMessage = 'Please select category';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10),
        content: Text(
          errorMessage,
          style: const TextStyle(fontSize: 17),
        )));
  }

  void addedSuccesully(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
        content: Text(
          'Recipe added succesfully',
          style: TextStyle(fontSize: 17),
        )));
  }
}

Widget addIngredients([GlobalKey? key,BuildContext? context]) {
  
  ObjectKey keys = const ObjectKey({});
  int index = ingredientsList.length;
  
  // Object _latestTextFieldIndex = -1;
  // bool isVisible = index == _latestTextFieldIndex;
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 4),
    child: SizedBox(
      height: 52,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              maxLines: 1,
              controller: controllers[index],
              onChanged: (value) {
                ingredientsList[index] = value;
                // setState(() {
                //   ingredientsList[index] = value;
                // });
              },
              key: keys,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        
                        if (key != null && context != null) {
                          BlocProvider.of<AddTextfeildBloc>(context).add(RemoveIngredientsTextField(index));
                          // removeTextField(key);
                        }
                        
                      },
                      icon: const Icon(Icons.clear)),
                  hintText: 'Add ingredients',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ],
      ),
    ),
  );
}
