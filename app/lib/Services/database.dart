// ignore_for_file: avoid_print

import "dart:io";
import "package:path_provider/path_provider.dart";
import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';
import "package:todolist_app/Services/task.dart";

class DatabaseManager {
  // static DatabaseManager? _instance;

  // DatabaseManager._();

  // static Future<DatabaseManager> instance() async {
  //   _instance ??= DatabaseManager._();
  //   return _instance!;
  // }

  static Database? _database;

  static String tableName = "task_table";
  static String colId = "id";
  static String colDesc = "desc";
  static String colStatus = "status";
  static String colDuedate = "duedate";
  static String colDueday = "dueday";

  static String databaseName = "task.db";

  static Future<Database> get database async {
    _database ??= await initializeDatabase();

    return _database!;
  }

  static Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databaseName);

    var testDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return testDatabase;
  }

  static Future<void> _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDesc TEXT, $colDuedate TEXT, $colStatus TEXT, $colDueday TEXT)");
  }

  static Future<void> addTask(Task task) async {
    final db = await database;
    print("add");

    int index = await db.insert(tableName, task.toMap());
    print("data added successfully at $index");
  }

  static Future<List<Task>> getTaskList() async {
    final db = await database;
    List<Map<String, dynamic>> jsonList = await db.query(tableName);

    List<Task> taskList = jsonList.map((json) => Task.fromJson(json)).toList();

    return taskList;
  }

  static Future<int> updateTask(int id, Task updatedTask) async {
    final db = await database;
    return await db.update(tableName, updatedTask.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databaseName);
    await deleteDatabase(path);

    print("Database deleted successfully!");
  }
}
