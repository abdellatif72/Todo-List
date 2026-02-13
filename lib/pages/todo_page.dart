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
    final prov = Provider.of<TodoProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your To Do'),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _input,
                          decoration: InputDecoration(
                            labelText: 'Task',
                            hintText: 'Add new task',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_input.text.isNotEmpty) {
                            prov.addTodo(_input.text);
                            _input.clear();
                          }
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
            
                  /// Show a the list of todos
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1
                            )
                          ),
                          child: ListTile(
                            title: Text(prov.todos[index].title),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      },
                      itemCount: prov.todos.length,
                    ),
                  ),
            
                  Text('Your remaining todos: ${prov.remainingTasks}')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
