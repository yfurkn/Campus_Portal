import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final String databaseName = "campus_portal.db";

  static Future<Database> databaseAccess() async{
    String databasePath = join(await getDatabasesPath(), databaseName);

    if(await databaseExists(databasePath)){
      print("The database already exists. No need to copy.");
    }
    else{
      ByteData data = await rootBundle.load("database/$databaseName");

      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes, flush: true);

      print("Database Copied.");
    }
    return openDatabase(databasePath);
  }

}
