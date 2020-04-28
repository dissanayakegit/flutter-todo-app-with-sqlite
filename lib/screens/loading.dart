import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:latest_todo/database/model.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  DatabaseConfiguration _databaseConfiguration = new DatabaseConfiguration();

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  void getAllTodos() async {
   var todos = await _databaseConfiguration.getAllToDos();
   print(todos);

    Navigator.pushNamed(context, '/todo-list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}