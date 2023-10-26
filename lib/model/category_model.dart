import 'package:flutter_todo_app/model/task_model.dart';

class Category {
   int id;
   String title;
   List<Task> tasks;


   Category({
    required this.id,
    required this.title,
    required this.tasks
   });

   String numOfTasksCompleted(){
     int tasksCompleted = 0;
     tasks.forEach((task) {
       if(task.isComplete){
         tasksCompleted++;
       }
     });

     return "$tasksCompleted of ${tasks.length} tasks completed";
   }
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