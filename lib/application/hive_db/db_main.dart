import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'db_all_abstract.dart';
import 'model/task_list_data_model.dart';

/// Run below code
/// flutter packages pub run build_runner build --delete-conflicting-outputs
class DbMain extends DbAllAbstract {
  static bool isDbInit = false;

  /// Store all tabs list data on dashboard
  String dashboardTabsDataBox = "task_list_data_box";


  // static Box? chatInBox;
  ///Init Hive db
  @override
  Future<bool> dbInit() async {
    if (!isDbInit) {
      try {
        final directory = await getApplicationDocumentsDirectory();
        Hive..init(directory.path,backendPreference: HiveStorageBackendPreference.native);
        print("Done");
        // await Hive.init(,backendPreference:dataBoxName);
      } catch (e) {
        print(e);
      }
      isDbInit = true;
    }

    try {
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TaskListDataModelAdapter());
      }
    } catch (e) {
      debugPrint("$e");
    }

    await dbOpen();

    return isDbInit;
  }

  ///Clear all Db
  @override
  Future<bool> dbClear() async {
    if (isDbInit) {
      try {
        var encryptedBox = Hive.box<TaskListDataModel>(dbMain.dashboardTabsDataBox);
        await encryptedBox.clear();
      } catch (e) {
        print(e);
      }
    }
    return true;
  }

  ///Clear all Db
  @override
  Future<bool> dbOpen() async {
    if (isDbInit) {
      await Hive.openBox<TaskListDataModel>(dbMain.dashboardTabsDataBox);
    }
    return true;
  }



  /// Delete selected item
  @override
  Future<bool> dbDeleteSelectedTable({String columnName = ""}) async {
    // TODO: implement dbColumnClear
    if (columnName.trim() != "") {
      await dbInit();
      Box box = await Hive.openBox<dynamic>(columnName);
      box.clear();
      box.close();
    }
    return true;
  }

  @override
  Box? getOpedBox(String boxName)  {
    if (isDbInit) {
      if(boxName == dashboardTabsDataBox){
        var encryptedBox = Hive.box<TaskListDataModel>(dbMain.dashboardTabsDataBox);
        if(encryptedBox.isNotEmpty && encryptedBox.isOpen){}
        else {
          // encryptedBox =  await Hive.openBox<DashboardTabListDataModel>(dbMain.dashboardTabsDataBox);
        }
        return encryptedBox;
      }
    }
    return null;
  }


  @override
  Future<void> closeBdBox({String? boxName,bool? all = false}) async {
    if (isDbInit) {
        var encryptedBox = Hive.box<TaskListDataModel>(dbMain.dashboardTabsDataBox);
        if(encryptedBox.isNotEmpty && encryptedBox.isOpen){
          encryptedBox.close();
        }
    }
  }

}

final DbMain dbMain = DbMain();
