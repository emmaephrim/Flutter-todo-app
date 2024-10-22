import 'package:uuid/uuid.dart';

class Todo {
  Todo({required this.name, required this.completed}) : id = const Uuid().v4();
  final String id;
  String name;
  bool completed;
  bool isSoftDeleted = false;
}
