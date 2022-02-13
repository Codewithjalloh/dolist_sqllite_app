import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection  {
  setDatbase() async {
    var dictionary = await getApplicationDocumentsDirectory();
    var path = join(dictionary.path, 'db_tolist_sqflite');
    var database = await openDatabase(path, version: 1, onCreate:_onCreatingDatabase);
    return database;
  }

  // create data
  _onCreatingDatabase(Database database, int version) async {
    await database.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");
  }





}