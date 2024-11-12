import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todoList.dart';
import 'package:flutter_todo_app/todo_provider.dart';
import 'package:flutter_todo_app/trash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TodoProvider(),
    child: const TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Manager',
      routes: {
        '/': (context) => TodoList(title: 'Todo List'),
        '/trash': (context) => const TrashPage(title: 'Trash'),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
