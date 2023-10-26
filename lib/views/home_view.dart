import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_manager.dart';
import 'tasks_view.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  late String newCategoryTitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(builder: (context, dataManager, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            "TodoApp",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              alignment: Alignment.topCenter,
              child: const Text(
                "Categories",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
                itemCount: dataManager.categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: TextButton(
                      child: Icon(Icons.close),
                      onPressed: () {
                        dataManager.removeCategory(index);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider.value(
                                      value: dataManager,
                                      child: TasksWidget(
                                          categoryId: dataManager
                                              .categories[index].id))));
                    },
                    title: Text(dataManager.categories[index].title),
                    titleTextStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                    subtitle: Text(dataManager.categories[index].numOfTasksCompleted()),
                    subtitleTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13
                    ),
                  );
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: const Text("Enter new Category"),
                      content: TextField(
                        decoration:
                            const InputDecoration(labelText: "Category"),
                        onChanged: (value) {
                          newCategoryTitle = value;
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              var categoryId = Provider.of<DataManager>(context,
                                      listen: false)
                                  .addCategory(newCategoryTitle);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider.value(
                                              value: dataManager,
                                              child: TasksWidget(
                                                  categoryId: categoryId))));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text("Done"),
                            ))
                      ],
                    ));
          },
          tooltip: 'New Category',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
