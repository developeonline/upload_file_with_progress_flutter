import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseConnection {
  static DatabaseConnection _databaseConnection; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  // Named Constructor to create instance of DatabaseHelper
  DatabaseConnection._createInstance();

  factory DatabaseConnection(){
    if (_databaseConnection == null) {
      _databaseConnection = DatabaseConnection
          ._createInstance(); // this is executed only once, singleton object
    }
    return _databaseConnection;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() {}
}