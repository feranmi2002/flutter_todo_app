import 'package:flutter/material.dart';
import 'package:flutter_todo_app/provider/data_manager.dart';
import 'package:provider/provider.dart';

class TasksWidget extends StatelessWidget {
  int categoryId;

  TasksWidget({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(builder: (context, dataManager, child) {
      var category = dataManager.categories
          .firstWhere((category) => category.id == categoryId);
      var tasks = category.tasks;
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text("${category.title} tasks",
              style: TextStyle(fontWeight: FontWeight.bold),)),
        body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  tasks[index].taskTitle
                ),
                leading: Checkbox(
                    value: tasks[index].isComplete,
                    onChanged: (value) {
                      dataManager.setTaskCompletion(
                          categoryId, tasks[index].id);
                    }),
                trailing: TextButton(
                  child: Icon(Icons.close),
                  onPressed: () {
                    dataManager.removeTaskFromCategory(
                        categoryId, tasks[index]);
                  },
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var newTaskTitle = "";
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: const Text("Enter new Task"),
                      content: TextField(
                        decoration:
                            const InputDecoration(labelText: "New Task"),
                        onChanged: (value) {
                          newTaskTitle = value;
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              dataManager.addTasksToCategory(
                                  categoryId, newTaskTitle);
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text("Done"),
                            ))
                      ],
                    ));
          },
          tooltip: 'New Task',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
