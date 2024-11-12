import 'dart:convert';

import 'package:flutter_todo_app/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoService {
  static const String todoKey = 'todos';

  // Save list of todos to sharedPreferences
  Future<void> saveTodo(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todoJson = jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString(todoKey, todoJson);
  }

  // Load list of todos from shared preferences
  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoJson = prefs.getString(todoKey);
    if (todoJson == null) return <Todo>[];

    final List<dynamic> todoList = jsonDecode(todoJson);
    return todoList.map((todo) => Todo.fromJson(todo)).toList();
  }

  // Clear all todos from shared preferences
  Future<void> clearTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(todoKey);
  }

  // Load list of deleted todos from shared preferences
  Future<List<Todo>> loadDeletedTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoJson = prefs.getString(todoKey);
    if (todoJson == null) return <Todo>[];

    final List<dynamic> todoList = jsonDecode(todoJson);
    return todoList.map((todo) => Todo.fromJson(todo)).where((todo) => todo.isSoftDeleted).toList();
  }

  // Find a todo from shared preferences
  // Future<Todo?> findTodoById(String id) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final todoJson = prefs.getString(todoKey);
  //   if (todoJson == null) return null;
  //
  //   final List<dynamic> todoList = jsonDecode(todoJson);
  //   return todoList.map((todo) => Todo.fromJson(todo)).firstWhere((todo) => todo.id == id, orElse: () => null);
  // }
}
