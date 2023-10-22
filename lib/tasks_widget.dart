import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data_manager.dart';
import 'package:provider/provider.dart';

class TasksWidget extends StatelessWidget{

  const TasksWidget({super.key, required int categoryId});

  final int categoryId = 0;
  @override
  Widget build(BuildContext context) {
   return Consumer<DataManager>(
      builder: (context, dataManager, child) {
        var tasks = dataManager.categories.firstWhere((element) => element.id == categoryId).tasks;
      return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title:  Text(dataManager.categories.firstWhere((element) => element.id == categoryId).title)
      ),
      body: ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return  ListTile(
          title: Text(tasks[index].taskTitle),  
          trailing: Checkbox(value: tasks[index].isComplete, onChanged:(value){
            dataManager.setTaskCompletion(categoryId, tasks[index].id);
          }  ),
          leading: TextButton(child: Icon(Icons.close),
          onPressed: (){
            dataManager.removeTaskFromCategory(categoryId, tasks[index]);
          } ,),  
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          var newTaskTitle = "";
          showDialog(context: context
          , builder: (ctx) => AlertDialog(
            title: const Text("Enter new Task"),
            content:  TextField(
              decoration: const InputDecoration(labelText: "New Task"),
              onChanged: (value) {
                newTaskTitle = value;
              },
            ),
            actions: <Widget>[
              TextButton(onPressed: (){
                dataManager.addTasksToCategory(categoryId,newTaskTitle );              
              }, child: Container(
                padding: const EdgeInsets.all(14),
                child: const Text("Done"),
              ))
            ],
            )
            );
        },
        tooltip: 'New Task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ); 
    }) ;
  }


}