import 'dart:io';
import 'package:cookbook/application/update/bloc/update_screen_bloc.dart';
import 'package:cookbook/application/update_image_bloc/bloc/update_image_bloc.dart';
import 'package:cookbook/infrastructure/recipe_db_function/db_recipe_functions.dart';
import 'package:cookbook/domain/recipe_model/recipies.dart';
import 'package:cookbook/presentation/screens/user/home_screen.dart';
import 'package:cookbook/presentation/widgets/add_ingredients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

String tempPath = '';

class UpdateScreen extends StatefulWidget {
  final int index;

  UpdateScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final List<GlobalKey> textKeys = [];
  final List<Widget> textfields = [];
  final List<TextEditingController> controllers = [];
  late List<String> ingredientsList = [];
  late TextEditingController _recipeNameController;
  late TextEditingController _durationController;
  late TextEditingController _categoryController;
  late TextEditingController _directionController;
  late TextEditingController _ingredientsController;
  // late TextEditingController _extraIngredientsController;

  late TextEditingController _youtubeLinkController;

  int id = 0;
  String? recipeName;
  String? duration;
  String? category;
  String? ingredients;
  List<String>? extraIngredients;
  String? direction;
  String? youtubeLink;
  String? imagePath;

  late Box<Recipes> recipeBox;
  late Recipes recipe;

  var itemsCategory = [
    'Category',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Indian',
    'Italian',
    'Arabian',
    'Chinese'
  ];
  String dropDownValue = 'Category';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // GlobalKey mainKey = GlobalKey();

    recipeBox = Hive.box('recipe_list');
    recipe = recipeBox.getAt(widget.index) as Recipes;
    // _ingredientsList = List.from(recipe.extraIngredients);

    _recipeNameController =
        TextEditingController(text: recipe.recipeName.toString());
    _durationController =
        TextEditingController(text: recipe.cookingTime.toString());
    _categoryController =
        TextEditingController(text: recipe.catogory.toString());
    _ingredientsController =
        TextEditingController(text: recipe.ingredients.toString());

    _directionController =
        TextEditingController(text: recipe.directions.toString());
    _youtubeLinkController = TextEditingController(text: recipe.url.toString());

    // print(_ingredientsList);

    for (int i = 0; i < recipe.extraIngredients.length; i++) {
      // print(recipe.extraIngredients[i]);
      // _ingredientsList.add(recipe.extraIngredients[i]);
      // print(_ingredientsList);
      controllers.add(TextEditingController());
      controllers[i].text = recipe.extraIngredients[i];
      // _ingredientsList.add(_controllers[i].text);
      // print(
      //     "_length ${_ingredientsList.length}, i = $i, ${recipe.extraIngredients[i]}");
      setTextField(recipe.extraIngredients[i]);

      // print(_controllers[i].text);
    }

    // print(_categoryController.text);
  }

  Future<void> imagePick() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      var tempPath = pickedImage.path;
      BlocProvider.of<UpdateImageBloc>(context)
          .add(OnImageChange(imagePath: tempPath));
      // setState(() {
      //   imagePath = pickedImage.path;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(238, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Update Recipe'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    child: BlocBuilder<UpdateImageBloc, UpdateImageState>(
                      builder: (context, state) {
                        tempPath = (tempPath != recipe.imagePath
                            ? state.imagePath
                            : tempPath)!;
                        return Container(
                          width: 200,
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imagePath == null
                                      ? FileImage(File(recipe.imagePath))
                                      : FileImage(File(
                                          imagePath ?? recipe.imagePath)))),
                        );
                      },
                    ),
                    onTap: () {
                      imagePick();
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
                    value: dropDownValue,
                    items: itemsCategory
                        .map(
                          (String itemsCategory) => DropdownMenuItem(
                            value: itemsCategory,
                            child: Text(itemsCategory),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        dropDownValue = value!;
                        category = value;
                        _categoryController.text = value;
                      });
                    },
                  ),
                ),
                szdBox(),
                BlocBuilder<UpdateScreenBloc, UpdateScreenState>(
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
                                onPressed: () {
                                  addTextField(state.controllers.length);
                                },
                                icon: Icon(Icons.add_box_outlined)),
                          ],
                        ),
                        ...textfields,
                      ],
                    );
                  },
                ),
                szdBox(),
                recipeText(_directionController, 'Directions for cook', 15),
                szdBox(),
                recipeText(_youtubeLinkController, 'Link to the video', 1),
                szdBox(),
                ElevatedButton.icon(
                    onPressed: () {
                      if (_recipeNameController.text.isNotEmpty &&
                          _durationController.text.isNotEmpty &&
                          _ingredientsController.text.isNotEmpty &&
                          dropDownValue != 'Category' &&
                          _directionController.text.isNotEmpty &&
                          _youtubeLinkController.text.isNotEmpty) {
                        onUpdateButtonClicked(widget.index);
                        // demo(widget.index);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (ctx) => HomeScreen(),
                            ),
                            (route) => false);
                      } else {
                        validCheck();
                      }
                    },
                    icon: Icon(Icons.update),
                    label: Text('Update'))
              ],
            ),
          ) 
        ],
      )),
    );
  }

  setTextField([String? textIngredients]) {
    setState(() {
      GlobalKey key = GlobalKey();
      // print("key $key");
      controllers.add(TextEditingController(text: textIngredients));
      textKeys.add(key);
      textfields.add(addIngredients(key));
      ingredientsList.add(textIngredients!);
      // _ingredientsList.add(textIngredients!);
    });
  }

  void addTextField(key) {
    print("legth = ${textfields.length}");
    BlocProvider.of<UpdateScreenBloc>(context).add(IncreaseIngredientsTextFeild(
        textFields: textfields,
        controllers: controllers,
        textKeys: textKeys,
        ingredientsList: ingredientsList));
        textfields.add(addIngredients(key));
        ingredientsList.add('');
    // setState(() {
    //   // print('1');
    //   GlobalKey key = GlobalKey();
    //   _controllers.add(TextEditingController());
    //   _textKeys.add(key);
    //   _textfields.add(addIngredients(key));
    //   // _ingredientsList.clear();
    //   _ingredientsList.add('');
    // });
  }

  void removeTextField(GlobalKey key) {
    setState(() {
      int index = textKeys.indexOf(key);
      // _controllers[index].dispose();
      controllers.removeAt(index);
      textfields.removeAt(index);
      textKeys.removeAt(index);
      ingredientsList.removeAt(index);
    });
  }

  Widget addIngredients(GlobalKey? key) {
    print('Entered');
    ObjectKey keys = const ObjectKey({});
    int index1 = ingredientsList.length;
    // print(index1);

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: 1,
                controller: controllers[index1],
                onChanged: (value) {
                  setState(() {
                    ingredientsList[index1] = value;
                  });
                },
                key: keys,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (key != null) {
                            removeTextField(key);
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

  validCheck() {
    var errorMessage = '';
    if (_recipeNameController.text.isEmpty &&
        _durationController.text.isEmpty &&
        _ingredientsController.text.isEmpty &&
        _directionController.text.isEmpty &&
        _youtubeLinkController.text.isEmpty) {
      errorMessage = 'Please fill all the fields';
    } else if (_recipeNameController.text.isEmpty) {
      errorMessage = 'Please add Recipe name';
    } else if (_durationController.text.isEmpty) {
      errorMessage = 'Please add cooking time';
    } else if (_ingredientsController.text.isEmpty) {
      errorMessage = 'Please add ingredients';
    } else if (_directionController.text.isEmpty) {
      errorMessage = 'Please add directions';
    } else if (_youtubeLinkController.text.isEmpty) {
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

  void addedSuccesully() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.green,
        content: Text(
          'Recipe added succesfully',
          style: TextStyle(fontSize: 17),
        )));
  }

  demo() {
    // _ingredientsList.clear();
    for (int i = 0; i < controllers.length; i++) {
      print(controllers[i].text);
      ingredientsList.add(controllers[i].text);
      print("_ingredientsListvalue = ${ingredientsList[i]}");
    }
  }

   onUpdateButtonClicked(int index) {
    print(index);
    print(" $ingredientsList");
    // recipe.extraIngredients.clear();
    // _ingredientsList.clear();
    // await demo();

    //  for(int i=0;i<_controllers.length;i++){
    //   print("text ${_controllers[i].text}");
    //    _ingredientsList.add(_controllers[i].text);
    // }
    final recipeName = _recipeNameController.text;
    final duration = _durationController.text;
    final category = dropDownValue;
    final ingredients = _ingredientsController.text;
    // final extraingredients = _ingredientsList;
    final direction = _directionController.text;
    final link = _youtubeLinkController.text;

    if (recipeName.isEmpty ||
        duration.isEmpty ||
        category == 'Category' ||
        ingredients.isEmpty ||
        direction.isEmpty ||
        link.isEmpty) {
      return;
    }
    final _updatedRecipe = Recipes(
        imagePath: imagePath ?? recipe.imagePath,
        recipeName: recipeName,
        cookingTime: duration,
        catogory: category,
        ingredients: ingredients,
        extraIngredients: ingredientsList,
        directions: direction,
        url: link);
    // print(_updatedRecipe.extraIngredients);
    // final recipeDB = await Hive.openBox<Recipes>('recipe_list');
    recipeBox.putAt(index, _updatedRecipe);
    getAllRecipe();
  }
}
