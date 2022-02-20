import 'package:dolist_sqllite_app/models/todo.dart';
import 'package:dolist_sqllite_app/services/todo_service.dart';
import 'package:flutter/material.dart';

class TodosByCategory extends StatefulWidget {
  final String category;
  TodosByCategory({this.category});

  @override
  _TodosByCategoryState createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Todo> _todoList = <Todo>[];
  TodoService _todoService = TodoService();

  @override
  initState() {
    super.initState();
    getTodosByCategory();
  }

  getTodosByCategory() async {
    var todos = await _todoService.readTodosByCategory(this.widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.title = todo["title"];
        model.description = todo["description"];
        model.todoDate = todo["todoDate"];

        _todoList.add(model);

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos By Category"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)
                    ),
                    elevation: 8,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[Text(_todoList[index].title)],
                      ),
                      subtitle: Text(_todoList[index].description),
                      trailing: Text(_todoList[index].todoDate) ,

                    ),
                  ),
                );
                }),
          )
        ],
      ),
    );
  }
}
