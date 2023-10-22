class Task {
  int id;
  String taskTitle;
  bool isComplete;

  Task({
    required this.id,
    required this.taskTitle,
    required this.isComplete
  });

  void updateTaskName(String newTaskTitle){
    taskTitle = newTaskTitle;
  }

  void setTaskCompletion(){
    isComplete = !isComplete;
  }
}