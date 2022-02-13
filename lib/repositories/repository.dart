import 'package:dolist_sqllite_app/repositories/database_connections.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection _databaseConnection;
  Repository() {
    // initialise database connection
    _databaseConnection = DatabaseConnection();
  }



  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatbase();
    return _database;
  }

  // inserting data to table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  // read data from table
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  // read data from table by id
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: "id=?", whereArgs: [itemId]);


  }

  // uodate data from table
  updateData(table, data) async {
    var connection = await database;
    return await connection.update(table, data, where: "id=?", whereArgs: [data["id"]]);
  }

}