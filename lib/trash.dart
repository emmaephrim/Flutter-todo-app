import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo_provider.dart';
import 'package:provider/provider.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: ListView(
          children: todoProvider.deletedTodos.map((todo) {
            return ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(todo.name),
                  ),
                  IconButton(
                    onPressed: () {
                      todoProvider.restore(todo);
                    },
                    icon: const Icon(Icons.recycling),
                    color: Colors.green,
                  ),
                  IconButton(
                    onPressed: () {
                      todoProvider.deleteForever(todo);
                    },
                    icon: const Icon(Icons.delete_forever),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ],
              ),
            );
          }).toList(),
        ));
  }
}
