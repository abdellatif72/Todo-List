import 'package:my_todo_app_1/models/todo.dart';
import 'package:flutter/foundation.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  int id = 0;

  int tasksDone = 0;
  int remainingTasks = 0;

  List<Todo> get todos => List.unmodifiable(_todos);

  // add todo
  void addTodo(String title) {
    if (title.isNotEmpty) {
      _todos.add(Todo(title: title, id: id));
    }
    id++;
    remainingTasks++;
    notifyListeners();
  }

  // remove todo
  void removeTodo(int id) {
    if (_todos[id].isDone) {
      tasksDone--;
    } else {
      remainingTasks--;
    }
    _todos.removeAt(id);
    this.id--;
    notifyListeners();
  }

  // toggle todo
  void toggleTodo(int id) {
    final todo = _todos[id];
    if(todo.isDone){
      tasksDone--;
      remainingTasks++;
    } else {
      tasksDone++;
      remainingTasks--;
    }
    todo.isDone = !todo.isDone;
    this.id--;

    notifyListeners();
  }
}
