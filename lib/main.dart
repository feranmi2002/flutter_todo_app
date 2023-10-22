import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data_manager.dart';
import 'package:flutter_todo_app/tasks_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => DataManager(),
    child: MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    )
    );
    
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  late String newCategoryTitle;
 
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Consumer<DataManager>(
      builder: (context, dataManager, child) {
      return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Todo App"),
      ),
      body: ListView.builder(
      itemCount: dataManager.categories.length,
      itemBuilder: (context, index) {
        return  ListTile(
          title: Text(dataManager.categories[index].title),    
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context
          , builder: (ctx) => AlertDialog(
            title: const Text("Enter new Category"),
            content:  TextField(
              decoration: const InputDecoration(labelText: "Category"),
              onChanged: (value) {
                newCategoryTitle = value;
              },
            ),
            actions: <Widget>[
              TextButton(onPressed: (){
                var categoryId = Provider.of<DataManager>(context, listen: false).addCategory(newCategoryTitle);  
                Navigator.push(context, MaterialPageRoute(builder: (context) => TasksWidget(categoryId: categoryId)));
              }, child: Container(
                padding: const EdgeInsets.all(14),
                child: const Text("Done"),
              ))
            ],
            )
            );
        },
        tooltip: 'New Category',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ); 
    }) ;
  }
}
