import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_iti/widgets/custom_elevated_button.dart';

import '../../models/panel_model.dart';
import '../../utils/select_time.dart';

class TaskBottomSheet extends StatefulWidget {
  final Function(PanelModel) onAdd;

  TaskBottomSheet({required this.onAdd});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  final TextEditingController textController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isTimeSelected = false;
  List<TaskItem> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text(
                      "Add Task",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(CupertinoIcons.xmark),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Time",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        selectTime(
                          onTimeSelected: (selectedTime, isTimeSelected) {
                            setState(() {
                              this.selectedTime = selectedTime;
                              this.isTimeSelected = isTimeSelected;
                            });
                          },
                          context: context,
                          selectedTime: selectedTime,
                          isTimeSelected: isTimeSelected,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xffbcbcbc),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.watch_later, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              isTimeSelected
                                  ? selectedTime.format(context)
                                  : "Select Time",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: TextStyle(fontSize: 19),
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter a task ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a task ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                IconButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final task = TaskItem(
                        description: textController.text,
                        isDone: false,
                      );
                      setState(() {
                        tasks.add(task);
                        textController.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.add, size: 30),
                  color: Colors.blue,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          tasks[index].description,
                          style: TextStyle(fontSize: 23),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                CustomElevatedButton(
                  buttonText: "Confirm",
                  onPressed: () {
                    if (!isTimeSelected || tasks.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Incomplete Information",
                              style: TextStyle(fontSize: 27),
                            ),
                            content: const Text(
                              "Please select a time and add at least one task before confirming.",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      final panel = PanelModel(
                        items: tasks,
                        time: selectedTime.format(context),
                        isExpanded: false,
                      );
                      widget.onAdd(panel);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
