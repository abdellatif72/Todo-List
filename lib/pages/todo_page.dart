import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    int doneTodo = 0;
    int remTodo = 0;
    final primaryColor = Color.fromRGBO(79, 79, 79, 1);
    final primaryColor2 = Color.fromRGBO(79, 79, 79, 0.7);
    final secondaryColor = Colors.grey[50];
    final prov = Provider.of<TodoProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your To Do'),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: primaryColor,
                            onSubmitted: (value) {
                              if (_input.text.isNotEmpty) {
                                prov.addTodo(_input.text);
                                _input.clear();
                              }
                            },
                            controller: _input,
                            decoration: InputDecoration(
                              // labelText: 'Task',
                              hintText: 'Add new task',

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            if (_input.text.isNotEmpty) {
                              prov.addTodo(_input.text);
                              _input.clear();
                            }
                          },
                          icon: Icon(Icons.add),
                          style: IconButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    /// Show
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          color: secondaryColor,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: primaryColor2),
                          ),
                          child: ListTile(
                            horizontalTitleGap: 0,
                            contentPadding: EdgeInsets.only(left: 5, right: 10),
                            leading: Checkbox(
                              mouseCursor: SystemMouseCursors.basic,
                              splashRadius: 0,
                              value: prov.todos[index].isDone,
                              onChanged: (bool? newValue) {
                                prov.toggleTodo(index);
                              },
                            ),
                            title: Text(
                              prov.todos[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: prov.todos[index].isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: const Icon(
                                Icons.close,
                                weight: 700,
                                size: 20,
                              ),
                              onPressed: () => prov.removeTodo(index),
                            ),
                          ),
                        );
                      },
                      itemCount: prov.todos.length,
                    ),
                    SizedBox(height: 10),

                    Text('Your remaining todos: ${prov.remainingTasks}'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
