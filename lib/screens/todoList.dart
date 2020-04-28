import 'package:flutter/material.dart';
import 'package:latest_todo/screens/updateTodo.dart';
import '../database/model.dart';

class AllToDos extends StatefulWidget {
  @override
  _AllToDosState createState() => _AllToDosState();
}

class _AllToDosState extends State<AllToDos> {

  DatabaseConfiguration _databaseConfiguration = new DatabaseConfiguration();
  ToDo todo;

  List<ToDo> todoList;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your ToDos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-new-todo');
            },
          )
        ],
      ),

      body: FutureBuilder(
        future: _databaseConfiguration.getAllToDos(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            todoList = snapshot.data;
          }
          return ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index){
               ToDo todo = todoList[index];

               return Card(
                 child: Row(
                   children: <Widget>[
                     Text('task : ${todo.task}'),

                     Expanded(
                       child: SizedBox(),
                     ),
                     
                     IconButton(
                       icon: Icon(Icons.edit),
                       onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UpdateTodo(todo.id)));                      
                       },
                     ),

                     IconButton(
                       icon: Icon(Icons.delete),
                       onPressed: () {
                         _databaseConfiguration.deleteToDO(todo);
                         setState(() {
                           todoList.removeAt(index);
                         });
                       },
                     ),
                   ],
                 ),
               ); 
            },
          );

        }
      ),
    );
  }
}