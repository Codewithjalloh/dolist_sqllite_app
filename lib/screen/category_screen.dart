import 'package:dolist_sqllite_app/models/category.dart';
import 'package:dolist_sqllite_app/screen/home_screen.dart';
import 'package:dolist_sqllite_app/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final _categoryNameController = TextEditingController();
  final _categoryDescriptionController = TextEditingController();

  final _category = Category();
  final _categoryService = CategoryService();


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
                onPressed: () {
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;
                  _categoryService.saveCategory(_category);
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
                children:  [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text("Category"),
      ),
      body: Center(child: Text("Welcome to the category screen")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showFormDialog(context);
        },
      ),
    );
  }
}
