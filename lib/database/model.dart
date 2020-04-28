import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class ToDo {
  int id;
  String task;

  ToDo({@required this.task, this.id});

  Map<String, dynamic> toMap() {
    return {'task' : task};
  }
  
  ToDo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    task = map['task'];
  }  
}

class DatabaseConfiguration {

  //create database instance
  Database _database;

  //create a function to open 

  Future openDB() async {
    if(_database == null){
      _database = await openDatabase(
        join(await getDatabasesPath(), "mydb.db"),
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
             "CREATE TABLE todos(id INTEGER PRIMARY KEY autoincrement, task TEXT)" 
          );
        }
      );
    }
  }

  //Add new todo
  Future <void> addToDO(ToDo todo) async {    
    await openDB();
    await _database.insert('todos', todo.toMap());
    return todo;
  }

  //get all todos
  Future <List<ToDo>> getAllToDos() async {
    await openDB();
    final List<Map<String, dynamic>> todos = await _database.query('todos');

    return List.generate(todos.length, (i) {
      return ToDo(
        id : todos[i]['id'],
        task : todos[i]['task'],
      );
    });
  }

  //get todo by id
  Future <ToDo> getToDoById(int id) async {
  await openDB();
  final List<Map> todos = await _database.query('todos', where: "id = ?", whereArgs: [id] );

  if(todos.length > 0){
    return ToDo.fromMap(todos.first);
  }
  return null;
}

  //update todo
  Future <void> updateToDO(ToDo todo) async {
    await openDB();
    var updatedTodo = await _database.update('todos', todo.toMap(), where: "id = ?", whereArgs: [todo.id]);
    return updatedTodo;
  }

  //delete todo
  Future <void> deleteToDO(ToDo todo) async  {
    await openDB();
    await _database.delete('todos', where: "id = ?", whereArgs: [todo.id]);
  }

}