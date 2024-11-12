import 'package:uuid/uuid.dart';

class Todo {
  Todo({required this.name, required this.completed, this.isSoftDeleted = false}) : id = const Uuid().v4();
  final String id;
  String name;
  bool completed;
  bool isSoftDeleted;

  // Convert a Todo into a Map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'completed': completed,
        'isSoftDeleted': isSoftDeleted,
      };

  // Covert a Map into a Todo Object
  factory Todo.fromJson(Map<String, dynamic> json) =>
      Todo(name: json['name'], completed: json['completed'], isSoftDeleted: json['isSoftDeleted']);
}
