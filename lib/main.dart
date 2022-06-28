import 'package:flutter/material.dart';
import 'package:hive_database_todo/screens/todolist_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_database_todo/adapter/todo.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos');// creating database
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Todolistscreen()
    );
  }
}

