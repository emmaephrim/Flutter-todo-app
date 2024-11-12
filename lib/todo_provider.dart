import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider with ChangeNotifier {
  static const String _todoKey = 'todos';
  List<Todo> _todos = [];

  List<Todo> get activeTodos => _todos.where((todo) => !todo.isSoftDeleted).toList();
  List<Todo> get deletedTodos => _todos.where((todo) => todo.isSoftDeleted).toList();

  TodoProvider() {
    _loadTodos();
  }

  // Save list of todos to sharedPreferences
  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoJson = jsonEncode(_todos.map((todo) => todo.toJson()).toList());
    await prefs.setString(_todoKey, todoJson);
  }

  // Load list of todos from shared preferences
  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoJson = prefs.getString(_todoKey);
    if (todoJson != null) {
      final List<dynamic> todoList = jsonDecode(todoJson);
      _todos = todoList.map((todo) => Todo.fromJson(todo)).toList();
      notifyListeners();
    }
  }

  // add new todo to the list
  void addTodo(String name) {
    _todos.add(Todo(
      name: name,
      completed: false,
    ));
    _saveTodos();
    notifyListeners();
  }

  // toggle todo completion status
  void toggleTodoStatus(Todo todo) {
    todo.completed = !todo.completed;
    _saveTodos();
    notifyListeners();
  }

  // soft delete a todo
  void softDelete(Todo todo) {
    todo.isSoftDeleted = true;
    _saveTodos();
    notifyListeners();
  }

  // restore a todo
  void restore(Todo todo) {
    todo.isSoftDeleted = false;
    _saveTodos();
    notifyListeners();
  }

  // delete a todo forever
  void deleteForever(Todo todo) {
    _todos.remove(todo);
    _saveTodos();
    notifyListeners();
  }

  // edit a todo
  void editTodo(Todo todo, String name) {
    todo.name = name;
    _saveTodos();
    notifyListeners();
  }
}
