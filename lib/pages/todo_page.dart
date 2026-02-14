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
    int doneTodo = 0;
    int remTodo = 0;
    final primaryColor = Color.fromRGBO(79, 79, 79, 1);
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
              constraints: BoxConstraints(maxWidth: 300),
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
                        return Dismissible(
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              prov.removeTodo(index);
                            }
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20.0),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          key: UniqueKey(),
                          child: Card(
                            color: secondaryColor,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: primaryColor, width: 1),
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: prov.todos[index].isDone,
                                onChanged: (bool? newValue){
                                  prov.toggleTodo(index);
                                },
                              ),
                              title: Text(prov.todos[index].title),
                              trailing: const Icon(Icons.arrow_forward_ios),
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
