import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app_1/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _input = TextEditingController();
  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromRGBO(79, 79, 79, 1);
    final prov = Provider.of<TodoProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  // Title
                  Text(
                    'Your To Do',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      fontFamily: 'Inter',
                      color: Color.fromRGBO(79, 79, 79, 1),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Add task text field
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: Color.fromRGBO(79, 79, 79, 0.4),
                          controller: _input,
                          decoration: InputDecoration(
                            hintText: 'Add new task',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(79, 79, 79, 0.7),
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(79, 79, 79, 0.7),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: () {
                          if (_input.text.isNotEmpty) {
                            prov.addTodo(_input.text);
                            _input.clear();
                          }
                        },
                        icon: Icon(Icons.add),
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Color.fromRGBO(79, 79, 79, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: prov.todos.length,
                      itemBuilder: (context, index) {
                        final todo = prov.todos[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(value: todo.isDone, onChanged: (_) => prov.toggleTodo(index)),
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: todo.isDone 
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () => prov.removeTodo(index),
                              icon: const Icon(Icons.delete_outline)
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
