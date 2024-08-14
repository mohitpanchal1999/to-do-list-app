import 'dart:convert';
import 'package:to_do_list_app/application/hive_db/model/task_list_data_model.dart';
import 'package:to_do_list_app/application/utils/exception_handler.dart';
import 'package:to_do_list_app/task/models/task_model.dart';
import '../../application/hive_db/db_main.dart';


class TaskDataProvider {
  List<TaskModel> tasks = [];
  TaskDataProvider();

  Future<List<TaskModel>> getTasks() async {
    try {
      /// Get Data from DB
      var encryptedBox = dbMain.getOpedBox(dbMain.dashboardTabsDataBox);
      List<TaskListDataModel>? savedTasks = [];
      savedTasks =  encryptedBox!.values.cast<TaskListDataModel>().toList();    
      if (savedTasks.isNotEmpty) {
        tasks = savedTasks
            .map((taskJson) => TaskModel.fromJson(taskJson.toJson()))
            .toList();
        tasks.sort((a, b) {
          if (a.id == b.id) {
            return 0;
          } else {
            return 1;
          }
        });
      }
      tasks.reversed;
      return tasks;
    }catch(e){
      throw Exception(handleException(e));
    }
  }

  Future<List<TaskModel>> sortTasks(int sortOption) async {
    switch (sortOption) {
      case 0:
        tasks.sort((a, b) {
          // Sort by date
          if (a.creationDateTime!.isAfter(b.creationDateTime!)) {
            return 1;
          } else if (a.creationDateTime!.isBefore(b.creationDateTime!)) {
            return -1;
          }
          return 0;
        });
        break;
      case 1:
      //sort by completed tasks
        tasks.sort((a, b) {
          if (!a.completed && b.completed) {
            return 1;
          } else if (a.completed && !b.completed) {
            return -1;
          }
          return 0;
        });
        break;
      case 2:
      //sort by pending tasks
        tasks.sort((a, b) {
          if (a.completed == b.completed) {
            return 0;
          } else if (a.completed) {
            return 1;
          } else {
            return -1;
          }
        });
        break;
    }
    tasks.reversed;
    return tasks;
  }

  Future<void> createTask(TaskModel taskModel) async {
    try {

      /// Create data in DB
        var encryptedBox = dbMain.getOpedBox(dbMain.dashboardTabsDataBox);
          String id = DateTime.now().millisecondsSinceEpoch.toString();
        taskModel.id = id;
        TaskListDataModel dashboardTabListDataModel = TaskListDataModel.fromJson(taskModel.toJson());
        encryptedBox!.put(id, dashboardTabListDataModel);

      tasks.add(taskModel);
    } catch (exception) {
      throw Exception(handleException(exception));
    }
  }

  Future<List<TaskModel>> updateTask(TaskModel taskModel) async {
    try {
      ///Update Data in DB
      var encryptedBox = dbMain.getOpedBox(dbMain.dashboardTabsDataBox);
      TaskListDataModel dashboardTabListDataModel = TaskListDataModel.fromJson(taskModel.toJson());
      encryptedBox!.put(taskModel.id, dashboardTabListDataModel);

      tasks[tasks.indexWhere((element) => element.id == taskModel.id)] =
          taskModel;
      tasks.sort((a, b) {
        if (a.completed == b.completed) {
          return 0;
        } else if (a.completed) {
          return 1;
        } else {
          return -1;
        }
      });
      return tasks;
    } catch (exception) {
      throw Exception(handleException(exception));
    }
  }

  Future<List<TaskModel>> deleteTask(TaskModel taskModel) async {
    try {

      /// Delete data from DB
      var encryptedBox = dbMain.getOpedBox(dbMain.dashboardTabsDataBox);
      String id = taskModel.id;
      await encryptedBox!.delete(id);

      tasks.remove(taskModel);
      return tasks;
    } catch (exception) {
      throw Exception(handleException(exception));
    }
  }

  Future<List<TaskModel>> searchTasks(String keywords) async {
    var searchText = keywords.toLowerCase();
    List<TaskModel> matchedTasked = tasks;
    return matchedTasked.where((task) {
      final titleMatches = task.title.toLowerCase().contains(searchText);
      final descriptionMatches = task.description.toLowerCase().contains(searchText);
      return titleMatches || descriptionMatches;
    }).toList();
  }
}