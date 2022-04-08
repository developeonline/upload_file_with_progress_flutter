import 'package:sqflite/sqflite.dart';
import '../../core/db/database_connection.dart';
import 'dart:async';


class DatabaseHelper{
  DatabaseConnection _databaseConnection = DatabaseConnection();

  Future<Database> get database async {
    return await _databaseConnection.database;
  }


}

/*
Well I managed to resolve my issue. With some help from dlohani comment and How to add new Column to Android SQLite Database link.

I created a new method "_onUpgrade" and call it as parameter of "openDatabase" and changed the version number. Following is my relevant code:

initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'maindb.db');
    var ourDb = await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return ourDb;
  }

  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE tabEmployee ADD COLUMN newCol TEXT;");
    }
  }
https://stackoverflow.com/questions/53928684/flutter-modify-sqlite-table-without-deleting-database
 */

/*
Conflict Algorithm
The APIs insert and update have a optional params conflictAlgorithm to explicit what to do in these cases.

The options of ConflictAlgorithm are:

rollback => When a constraint violation occurs, an immediate ROLLBACK occurs, thus ending the current transaction, and the command aborts with a return code of SQLITE_CONSTRAINT. If no transaction is active (other than the implied transaction that is created on every command) then this algorithm works the same as ABORT.

abort => When a constraint violation occurs,no ROLLBACK is executed so changes from prior commands within the same transaction are preserved. This is the default behavior.

fail => When a constraint violation occurs, the command aborts with a return code SQLITE_CONSTRAINT. But any changes to the database that the command made prior to encountering the constraint violation are preserved and are not backed out.

ignore => When a constraint violation occurs, the one row that contains the constraint violation is not inserted or changed. But the command continues executing normally. Other rows before and after the row that contained the constraint violation continue to be inserted or updated normally. No error is returned.

replace => When a UNIQUE constraint violation occurs, the pre-existing rows that are causing the constraint violation are removed prior to inserting or updating the current row. Thus the insert or update always occurs. The command continues executing normally. No error is returned. If a NOT NULL constraint violation occurs, the NULL value is replaced by the default value for that column. If the column has no default value, then the ABORT algorithm is used. If a CHECK constraint violation occurs then the IGNORE algorithm is used. When this conflict resolution strategy deletes rows in order to satisfy a constraint, it does not invoke delete triggers on those rows. This behavior might change in a future release.


 */