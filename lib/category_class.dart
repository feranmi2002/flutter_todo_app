import 'package:flutter_todo_app/task.dart';

class Category {
   int id;
   String title;
   List<Task> tasks;


   Category({
    required this.id,
    required this.title,
    required this.tasks
   });

void updateCategoryName(String newCategoryTitle){
   title = newCategoryTitle;
  }

  void addTasksToCategory(String taskTitle){
tasks.add(Task(id: tasks.length + 1, taskTitle: taskTitle, isComplete: false));
  }

  void removeTaskFromCategory(Task task){
    tasks.remove(task);
  }

  void setTaskCompletion(int taskID){
    var task = tasks.firstWhere((element) => element.id == taskID);
    task.setTaskCompletion();
  }

  void updateTaskName(int taskID, String newTaskTitle){
    var task = tasks.firstWhere((element) => element.id == taskID);
    task.updateTaskName(newTaskTitle);
  }
}