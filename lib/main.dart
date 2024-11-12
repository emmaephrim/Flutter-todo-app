import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todoList.dart';
import 'package:flutter_todo_app/trash.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Manager',
      routes: {
        '/': (context) => const TodoList(title: 'Todo List'),
        '/trash': (context) => const TrashPage(title: 'Trash'),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
