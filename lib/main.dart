import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_iti/constants.dart';
import 'package:todo_iti/views/home_page.dart';

import 'models/panel_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PanelModelAdapter());
  Hive.registerAdapter(TaskItemAdapter());
  await Hive.openBox<PanelModel>(kTasksBox);
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
