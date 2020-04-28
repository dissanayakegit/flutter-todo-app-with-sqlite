import 'package:flutter/material.dart';
import 'package:latest_todo/database/model.dart';

// ignore: must_be_immutable
class UpdateTodo extends StatefulWidget {
  int id;
  UpdateTodo(this.id);
  
  @override
  _UpdateTodoState createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {

  final DatabaseConfiguration _databaseConfiguration = new DatabaseConfiguration();
  ToDo todo;
  final _formKey = new GlobalKey<FormState>();
  final taskInputController = TextEditingController();


  @override
  void initState() {
    super.initState();
    getRecordById();
  }

  void getRecordById() async {
     var todo = await _databaseConfiguration.getToDoById(widget.id);
     taskInputController.text = todo.task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Todo'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
            TextFormField(
              controller: taskInputController,
            ),

            // Expanded(
            //   child: SizedBox(height: 22.0,),
            // ),

            IconButton(
              icon: Icon(Icons.add),

              onPressed: () {
                ToDo todo = new ToDo(task: taskInputController.text, id: widget.id);
                _databaseConfiguration.updateToDO(todo).then( (id) => {
                    taskInputController.clear(),
                    print('Updated record at id ${todo.id}'),
                    Navigator.pushNamed(context, '/todo-list')
                } );
                
              },
            ),
            
          ],
        )),
      ),
    );
  }
}