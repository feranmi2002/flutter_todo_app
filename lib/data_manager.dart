import 'package:flutter/material.dart';
import 'package:flutter_todo_app/category_class.dart';
import 'package:flutter_todo_app/task.dart';

class DataManager extends ChangeNotifier{
  List<Category> categories = [];

  void addCategory(String categoryTitle ){
    Category newCategory = Category(id: categories.length + 1, title: categoryTitle, tasks: List.empty(growable: true));
    categories.add(newCategory);
    notifyListeners();
  }

  void updateCategoryName(int categoryId, String newCategoryTitle){
    var category = categories.firstWhere((element) => element.id == categoryId);
    category.updateCategoryName(newCategoryTitle);
    notifyListeners();
  }

  void addTasksToCategory(int categoryId, String taskTitle){
    var category = categories.firstWhere((element) => element.id == categoryId);
    category.addTasksToCategory(taskTitle);
    notifyListeners();
  }

  void removeTaskFromCategory(int categoryId, Task task){
    var category = categories.firstWhere((element) => element.id == categoryId);
    category.removeTaskFromCategory(task);
    notifyListeners();
  }

  void setTaskCompletion(int categoryId, int taskID){
    var category = categories.firstWhere((element) => element.id == categoryId);
    category.setTaskCompletion(taskID);
    notifyListeners();
  }

  void updateTaskName(int categoryId, int taskID, String newTaskTitle){
    var category = categories.firstWhere((element) => element.id == categoryId);
    category.updateTaskName(taskID, newTaskTitle);
    notifyListeners();
  }
}