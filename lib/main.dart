import 'package:flutter/material.dart';
import 'package:latest_todo/screens/addNewTodo.dart';
import 'package:latest_todo/screens/loading.dart';
import 'package:latest_todo/screens/todoList.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',

  routes: {
    '/' : (context) => Loading(),
    '/todo-list' : (context) =>  AllToDos(),
    '/add-new-todo' : (context) => AddNewToDo(),
  },
));