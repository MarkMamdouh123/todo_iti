import 'package:hive/hive.dart';
part 'panel_model.g.dart';

@HiveType(typeId: 0)
class PanelModel extends HiveObject {
  @HiveField(0)
  List<TaskItem> items;
  @HiveField(1)
  String time;
  @HiveField(2)
  bool? isCompleted;
  @HiveField(3)
  bool isExpanded = false;

  PanelModel({
    required this.items,
    required this.time,
    this.isCompleted,
    required this.isExpanded,
  });
}

@HiveType(typeId: 1)
class TaskItem {
  @HiveField(0)
  String description;
  @HiveField(1)
  bool isDone;

  TaskItem({required this.description, required this.isDone});
}
