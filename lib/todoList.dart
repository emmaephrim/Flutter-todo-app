import 'package:flutter/material.dart';
import 'package:flutter_todo_app/helpers.dart';
import 'package:flutter_todo_app/todo.dart';
import 'package:flutter_todo_app/todo_provider.dart';
import 'package:flutter_todo_app/trash.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  TodoList({super.key, required this.title});
  final String title;

  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayDialog(BuildContext context, TodoProvider todoProvider, [Todo? todo]) async {
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
                  todoProvider.editTodo(todo, _textFieldController.text);
                  return;
                }
                todoProvider.addTodo(_textFieldController.text);
                _textFieldController.clear();
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
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
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
      body: todoProvider.activeTodos.isEmpty
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
              children: todoProvider.activeTodos.map((Todo todo) {
                return TodoItem(
                  todo: todo,
                  textFieldController: _textFieldController,
                  showEditDialog: _displayDialog,
                );
              }).toList(),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context, todoProvider),
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
