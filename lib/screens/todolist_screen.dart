import 'package:flutter/material.dart';
import 'package:hive_database_todo/adapter/todo.dart';
import 'package:hive_database_todo/screens/createtodo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Todolistscreen extends StatelessWidget {
  const Todolistscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Items"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>('todos').listenable(),
        builder: (context, Box<Todo> box, widget) {
          if (box.values.isEmpty) {
            return Center(
              child: Text("No data available"),
            );
          }
          return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Todo? obj = box.getAt(index);
                return ListTile(
                  title: Text(obj!.note),
                  subtitle: Text(obj!.task),
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Delete"),
                              content: Text("Are you sure want to Delete"),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    box.deleteAt(index).then((value) => print("Item deleted"));
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ok"),
                                ),FlatButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text("Cancel"))
                              ],
                            ));
                    //
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => createtodo()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
