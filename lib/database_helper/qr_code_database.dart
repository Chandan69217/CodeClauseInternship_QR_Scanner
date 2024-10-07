import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/utilities/consts.dart';
import 'package:sqflite/sqflite.dart';

class QrCodeDatabase{
  QrCodeDatabase._privateConstructor();
  static final QrCodeDatabase instance = QrCodeDatabase._privateConstructor();
  Database? _database;

  Future<Database> getDatabase() async {
    Directory _applicationPath = await getApplicationDocumentsDirectory();
    String _path = join(_applicationPath.path,'qr_details.db');
    if(_database != null){
      return _database!;
    }else{
      return await openDatabase(_path,version: 1,onCreate: (database,version){
        database.execute("CREATE TABLE ${Consts.TABLE_NAME}(${Consts.SERIAL_NO} INTEGER PRIMARY KEY AUTOINCREMENT,${Consts.SCAN_TYPE} TEXT,${Consts.SCAN_DATA} TEXT,${Consts.DATE_TIME} TEXT)");
      });
    }
  }

  Future<bool> insertData(Map<String,dynamic> data) async {
    int rowEffected;
    Database db = await getDatabase();
    rowEffected = await db.insert(Consts.TABLE_NAME, data);
    if(rowEffected > 0){
      return true;
    }else{
      return false;
    }
  }

  Future<List<Map<String,dynamic>>> getAllData() async{
    Database db = await getDatabase();
    List<Map<String,dynamic>> data;
    data = await db.query(Consts.TABLE_NAME);
    return data;
  }

  Future<bool> deleteAll() async {
    int rowEffectedCount;
    Database db = await getDatabase();
    rowEffectedCount = await db.delete(Consts.TABLE_NAME);

    if(rowEffectedCount>0){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> delete(int serialNo) async {
    int rowEffectedCount;
    Database db = await getDatabase();
    rowEffectedCount = await db.delete(Consts.TABLE_NAME,where: '${Consts.SERIAL_NO} = $serialNo');
    if(rowEffectedCount>0){
      return true;
    }else{
      return false;
    }
  }

  Future<void> closeDatabase() async{
    getDatabase().then((db){
      db.close();
    });
  }

}