import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/todo_page.dart';
import 'providers/todo_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        platform: TargetPlatform.iOS
      ),
      debugShowCheckedModeBanner: false,
      home: const TodoPage(),
    );     
  }
}