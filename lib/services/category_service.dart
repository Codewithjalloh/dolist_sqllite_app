import 'package:dolist_sqllite_app/models/category.dart';
import 'package:dolist_sqllite_app/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();

  }

  saveCategory(Category category) async {
    return await _repository.insertData("categories", category.categoryMap());
  }

  // read data
  readCategories() async {
    return await _repository.readData("categories");

  }
}