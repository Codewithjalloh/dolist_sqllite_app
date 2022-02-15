import 'package:dolist_sqllite_app/models/category.dart';
import 'package:dolist_sqllite_app/screen/home_screen.dart';
import 'package:dolist_sqllite_app/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final _categoryNameController = TextEditingController();
  final _categoryDescriptionController = TextEditingController();

  final _editCategoryNameController = TextEditingController();
  final _editCategoryDescriptionController = TextEditingController();

  final _category = Category();
  final _categoryService = CategoryService();

  var category;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();


  List<Category> _categoryList = [];

  @override
  void initState() {
    super.initState();
    getAllCatgories();
  }

  getAllCatgories() async {
    _categoryList = [];
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category["name"];
        categoryModel.description = category["description"];
        categoryModel.id = category["id"];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]["name"] ?? "No Name";
      _editCategoryDescriptionController.text =
          category[0]["description"] ?? "No Description";
    });
    _editFormDialog(context);
  }


  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
                style: TextButton.styleFrom(
                  primary: Colors.red,),

              ),

              TextButton(
                onPressed: () async {
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;
                  var result = await _categoryService.saveCategory(_category);

                  if (result > 0) {
                    print(result);
                    Navigator.pop(context);
                    getAllCatgories();
                    _showSuccessSnackBar(Text("Saved"));
                  }


                },
                child: Text("Save",),
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                ),
              ),

            ],
            title: const Text("categories form"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                      hintText: "Write a category",
                      labelText: "Category",
                    ),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                      hintText: "Write a decriptions",
                      labelText: "Description",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
                style: TextButton.styleFrom(
                  primary: Colors.red,),

              ),

              TextButton(
                onPressed: () async {
                  _category.id = category[0]["id"];
                  _category.name = _editCategoryNameController.text;
                  _category.description = _editCategoryDescriptionController.text;


                  var result = await _categoryService.updateCatory(_category);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCatgories();
                    _showSuccessSnackBar(Text("Updated"));
                  }
                },
                child: Text("Update",),
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                ),
              ),

            ],
            title: const Text("Edit Categories form"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editCategoryNameController,
                    decoration: InputDecoration(
                      hintText: "Write a category",
                      labelText: "Category",
                    ),
                  ),
                  TextField(
                    controller: _editCategoryDescriptionController,
                    decoration: InputDecoration(
                      hintText: "Write a decriptions",
                      labelText: "Description",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
                style: TextButton.styleFrom(
                  primary: Colors.green,),

              ),

              TextButton(
                onPressed: () async {


                  var result = await _categoryService.deleteCategory(categoryId);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCatgories();
                    _showSuccessSnackBar(Text("Deleted"),);
                  }
                },
                child: Text("Delete",),
                style: TextButton.styleFrom(
                  primary: Colors.red,
                ),
              ),

            ],
            title: const Text("Are you sure you want to delete this"),

          );
        });
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () =>
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text("Category"),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editCategory(context, _categoryList[index].id);
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList[index].name),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red,),
                        onPressed: () {
                          _deleteFormDialog(context, _categoryList[index].id);
                        },),
                    ],
                  ),
                  //subtitle: Text(_categoryList[index].description),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showFormDialog(context);
        },
      ),
    );
  }
}
