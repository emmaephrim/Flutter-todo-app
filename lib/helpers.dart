import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo.dart';
import 'package:flutter_todo_app/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoItem extends StatelessWidget {
  TodoItem({required this.todo, required this.textFieldController, required this.showEditDialog})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final TextEditingController textFieldController;
  final void Function(BuildContext context, TodoProvider todoProvider, [Todo? todo]) showEditDialog;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    return ListTile(
      onTap: () => todoProvider.toggleTodoStatus(todo),
      leading: Checkbox(
        checkColor: Colors.white,
        activeColor: Theme.of(context).colorScheme.primary,
        value: todo.completed,
        onChanged: (value) {
          todoProvider.toggleTodoStatus(todo);
        },
      ),
      title: Row(children: <Widget>[
        Expanded(
          child: Text(todo.name, style: _getTextStyle(todo.completed)),
        ),
        IconButton(
            onPressed: () {
              showEditDialog(context, todoProvider, todo);
              textFieldController.text = todo.name;
            },
            icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.inverseSurface)),
        IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.primary,
          ),
          alignment: Alignment.centerRight,
          onPressed: () => todoProvider.softDelete(todo),
        ),
      ]),
    );
  }
}
