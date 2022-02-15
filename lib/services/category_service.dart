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

  // read data from table by id
  readCategoryById(categoryId) async {
    return await _repository.readDataById("categories", categoryId);
  }

  // update date from table
  updateCatory(Category category) async {
    return await _repository.updateData("categories", category.categoryMap());
  }

  // delete category
  deleteCategory(categoryId) async {
    return await _repository.deteleData("categories", categoryId);
  }
}