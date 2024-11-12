import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo.dart';
import 'package:flutter_todo_app/todo_service.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key, required this.title});
  final String title;

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  final TodoService _todoService = TodoService();
  final List<Todo> _deletedTodos = <Todo>[];

  @override
  void initState() {
    super.initState();
    _loadDeletedTodos();
  }

  void _loadDeletedTodos() async {
    final deletedTodos = await _todoService.loadDeletedTodos();
    setState(() {
      _deletedTodos.addAll(deletedTodos);
    });
  }

  void _restoreTodoItem(Todo todo) {
    setState(() {
      _deletedTodos.where((element) => element.id == todo.id).first.isSoftDeleted = false;
    });
    _todoService.saveTodo(_deletedTodos);
  }

  void _deleteTodoItem(Todo todo) {
    setState(() {
      _deletedTodos.remove(todo);
    });
    _todoService.saveTodo(_deletedTodos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView(
          children: _deletedTodos.map((todo) {
            return ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(todo.name),
                  ),
                  IconButton(
                    onPressed: () {
                      _restoreTodoItem(todo);
                    },
                    icon: const Icon(Icons.recycling),
                    color: Colors.green,
                  ),
                  IconButton(
                    onPressed: () {
                      _deleteTodoItem(todo);
                    },
                    icon: const Icon(Icons.delete_forever),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ],
              ),
            );
          }).toList(),

          // [
          //   ListTile(
          //     title: Row(
          //       children: <Widget>[
          //         const Expanded(
          //           child: Text('Trash is empty'),
          //         ),
          //         IconButton(onPressed: () {}, icon: const Icon(Icons.recycling), color: Colors.green),
          //         IconButton(
          //             onPressed: () {},
          //             icon: const Icon(Icons.delete_forever),
          //             color: Theme.of(context).colorScheme.error),
          //       ],
          //     ),
          //   )
          // ],
        ));
  }
}
