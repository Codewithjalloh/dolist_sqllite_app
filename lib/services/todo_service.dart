import 'package:dolist_sqllite_app/models/todo.dart';

import 'package:dolist_sqllite_app/repositories/repository.dart';
class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  saveTodo(Todo todo) async {
    return await _repository.insertData("todos", todo.todoMap());
  }
}