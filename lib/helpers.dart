import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo.dart';

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.todo,
      required this.onTodoChanged,
      required this.onTodoDeleted,
      required this.textFieldController,
      required this.showEditDialog})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) onTodoDeleted;
  final TextEditingController textFieldController;
  final void Function([Todo? todo]) showEditDialog;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTodoChanged(todo),
      leading: Checkbox(
        checkColor: Colors.white,
        activeColor: Theme.of(context).colorScheme.primary,
        value: todo.completed,
        onChanged: (value) {
          onTodoChanged(todo);
        },
      ),
      title: Row(children: <Widget>[
        Expanded(
          child: Text(todo.name, style: _getTextStyle(todo.completed)),
        ),
        IconButton(
            onPressed: () {
              showEditDialog(todo);
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
          onPressed: () => onTodoDeleted(todo),
        ),
      ]),
    );
  }
}
