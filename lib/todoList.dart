import 'package:flutter/material.dart';
import 'package:flutter_todo_app/helpers.dart';
import 'package:flutter_todo_app/todo.dart';
import 'package:flutter_todo_app/trash.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});
  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> _todos = <Todo>[];
  final List<Todo> _trash = <Todo>[];
  final TextEditingController _textFieldController = TextEditingController();

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, completed: false));
      _textFieldController.clear();
    });
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void _editTodoItem(String id, String name) {
    setState(() {
      _todos.where((element) => element.id == id).first.name = name;
      _textFieldController.clear();
    });
  }

  void _deleteTodoItem(Todo todo) {
    setState(() {
      _todos.where((element) => element.id == todo.id).first.isSoftDeleted = true;
    });
  }

  Future<void> _displayDialog([Todo? todo]) async {
    return showDialog<void>(
      context: context,
      // T: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your todo'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (todo != null) {
                  _editTodoItem(todo.id, _textFieldController.text);
                  return;
                }
                _addTodoItem(_textFieldController.text);
              },
              child: todo != null ? const Text('Edit') : const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TrashPage(title: 'Trash')),
                );
              },
              icon: const Icon(Icons.recycling_sharp))
        ],
      ),
      body: _todos.isEmpty
          ? const Center(
              child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "No todo exists. Please create one and track your work",
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ))
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: _todos.where((Todo todo) => !todo.isSoftDeleted).map((Todo todo) {
                return TodoItem(
                  todo: todo,
                  onTodoChanged: _handleTodoChange,
                  onTodoDeleted: _deleteTodoItem,
                  textFieldController: _textFieldController,
                  showEditDialog: _displayDialog,
                );
              }).toList(),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
