import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database_todo/adapter/todo.dart';

class createtodo extends StatefulWidget {
  const createtodo({Key? key}) : super(key: key);

  @override
  _createtodoState createState() => _createtodoState();
}

class _createtodoState extends State<createtodo> {
  final _formkey = GlobalKey<FormState>();
  String note = '';
  String task = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Add Todo Item"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      note = value;
                    });
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      task = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      Box<Todo> box = Hive.box<Todo>('todos');
                      box.add(Todo(note, task));
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: Text("Submit"),
                )
              ],
            ),
          ),
        ));
  }
}
