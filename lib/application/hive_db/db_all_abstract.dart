import 'package:hive/hive.dart';

abstract class DbAllAbstract {
  ///Clear all data
  Future<bool> dbInit();

  ///Clear all data
  Future<bool> dbOpen();

  ///Clear all data
  Future<bool> dbClear();


  ///Clear all data
  Box? getOpedBox(String boxName);

  ///Clear all data
  Future<void> closeBdBox({String? boxName,bool? all = false});

  ///Clear selected column
  Future<bool> dbDeleteSelectedTable({required String columnName});

}

