import 'package:flutter/material.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key, required this.title});
  final String title;

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text('No items in trash'),
          );
        },
      ),
    );
  }
}
