import 'package:flutter/material.dart';

import 'models/todo_item.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Todo App'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController;
  List<TodoItem> todoList = [];

  @override
  void initState() {
    super.initState();

    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildTodoList(),
            buildTodoInput(),
            SizedBox(height: 16),
            buildColorPalette(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget buildColorPalette() {
    var colors = [
      Colors.yellow,
      Colors.red,
      Colors.blue,
      Colors.purple,
    ];

    List<Widget> colorWidgets = [];

    for (var color in colors) {
      colorWidgets.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          width: 72,
          height: 36,
          color: color,
        ),
      ));
    }

    return Row(
      children: colorWidgets,
    );
  }

  Widget buildTodoInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter text',
            ),
          ),
        ),
        SizedBox(width: 12),
        IconButton(
          iconSize: 42,
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            setState(() {
              todoList.add(TodoItem(
                text: textEditingController.text,
                color: Colors.transparent,
              ));
              textEditingController.text = '';
            });
          },
        ),
      ],
    );
  }

  Widget buildTodoList() {
    List<Widget> childWidgets = [];
    for (var i = 0; i < todoList.length; i++) {
      childWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(todoList[i].text),
                ),
                buildDoneButton(i),
              ],
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView(
        children: childWidgets,
      ),
    );
  }

  Widget buildDoneButton(int index) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            width: 2,
            color: Colors.grey,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              todoList.removeAt(index);
            });
          },
        ),
      ],
    );
  }
}
