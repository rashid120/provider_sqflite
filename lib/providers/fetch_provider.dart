import 'package:flutter/material.dart';
import 'package:provide_sqflite/sqflite_helper.dart';

class FetchProvider with ChangeNotifier{

  List<Map<String, dynamic>> data = [];

  Future<void> fetchDataP() async{

    await SqfliteHelper().database();
    List<Map<String, dynamic>> newData = await SqfliteHelper().fetchData();
    data = newData;
    notifyListeners();
  }

  Future<void> insertDataP(Map<String, dynamic> value) async{

    var db = await SqfliteHelper().database();
    await db.insert(SqfliteHelper.tableName, value);
  }
}