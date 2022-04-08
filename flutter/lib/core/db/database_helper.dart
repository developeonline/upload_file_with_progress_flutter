import 'package:sqflite/sqflite.dart';
import '../../core/db/database_connection.dart';
import 'dart:async';

class DatabaseHelper{
  DatabaseConnection _databaseConnection = DatabaseConnection();

  Future<Database> get database async {
    return await _databaseConnection.database;
  }


}
