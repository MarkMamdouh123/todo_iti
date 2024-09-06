import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/panel_model.dart';
import '../controllers/task_controller.dart'; // Import your TaskController

class ExpansionPanelDemo extends StatefulWidget {
  final PanelModel panel;
  final VoidCallback onDelete;

  const ExpansionPanelDemo({
    super.key,
    required this.panel,
    required this.onDelete,
  });

  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Container(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: Colors.blue, width: 2),
            ),
          ),
          child: ExpansionPanelList(
            dividerColor: Colors.blue,
            expandedHeaderPadding: const EdgeInsets.all(10),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                widget.panel.isExpanded = isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                backgroundColor: const Color(0xfff6f6f6),
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  int completedTasks =
                      widget.panel.items.where((task) => task.isDone).length;
                  int totalTasks = widget.panel.items.length;

                  return ListTile(
                    contentPadding:
                        EdgeInsets.only(top: 18, bottom: 18, left: 2),
                    title: Text(
                      widget.panel.time,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: completedTasks == totalTasks
                              ? Colors.green
                              : Colors.orange),
                      completedTasks == totalTasks
                          ? "Completed"
                          : "$completedTasks/$totalTasks Tasks Completed",
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: widget.panel.items.map((task) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            task.description,
                            style: TextStyle(
                                fontSize: 22,
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          leading: Checkbox(
                            value: task.isDone,
                            onChanged: (value) {
                              setState(() {
                                task.isDone = value!;
                              });
                            },
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _showEditDialog(task);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  _deleteTask(task);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                isExpanded: widget.panel.isExpanded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteTask(TaskItem task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Delete Task",
            style: TextStyle(fontSize: 22),
          ),
          content: const Text(
            "Are you sure you want to delete this task?",
            style: TextStyle(fontSize: 22),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  TaskController.deleteTask(widget.panel, task);
                  if (widget.panel.items.isEmpty) {
                    widget.onDelete();
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                "Delete",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  // Handle Task Editing
  void _showEditDialog(TaskItem task) {
    final TextEditingController editingController =
        TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Edit Task",
            style: TextStyle(fontSize: 22),
          ),
          content: TextField(
            style: TextStyle(fontSize: 20),
            controller: editingController,
            decoration: const InputDecoration(
              hintText: "Edit this task",
              hintStyle: TextStyle(fontSize: 22),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel", style: TextStyle(fontSize: 22)),
            ),
            TextButton(
              onPressed: () {
                if (editingController.text.isNotEmpty) {
                  setState(() {
                    TaskController.editTask(task, editingController.text);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                "Update",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        );
      },
    );
  }
}
