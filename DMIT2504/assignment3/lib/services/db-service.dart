// ignore_for_file: todo, avoid_print, library_prefixes, avoid_function_literals_in_foreach_calls, file_names, unused_import

import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;

class SQFliteDbService {
  late sqflitePackage.Database db;
  late String path;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      String databasesPath = await sqflitePackage.getDatabasesPath();
      path = pathPackage.join(databasesPath, 'stocks.db');
      db = await sqflitePackage.openDatabase(
        path,
        version: 1,
        onCreate: (sqflitePackage.Database db, int version) async {
          await db.execute(
            'CREATE TABLE Stocks(id INTEGER PRIMARY KEY, symbol TEXT, name TEXT, price TEXT)',
          );
        },
      );
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
  }

  Future<void> printAllStocksInDbToConsole() async {
    try {
      final List<Map<String, dynamic>> stocks = await db.query('Stocks');
      for (var stock in stocks) {
        print(stock);
      }
    } catch (e) {
      print('SQFliteDbService printAllStocksInDbToConsole: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllStocksFromDb() async {
    try {
      final List<Map<String, dynamic>> stocks = await db.query('Stocks');
      return stocks;
    } catch (e) {
      print('SQFliteDbService getAllStocksFromDb: $e');
      return <Map<String, dynamic>>[];
    }
  }

  Future<void> deleteDb() async {
    try {
      await sqflitePackage.deleteDatabase(path);
      print('Not Implemented Yet');
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertStock(Map<String, dynamic> stock) async {
    try {
      await db.insert(
        'Stocks',
        stock,
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertStock: $e');
    }
  }

  Future<void> updateStock(Map<String, dynamic> stock) async {
    try {
      await db.update(
        'Stocks',
        stock,
        where: 'id = ?',
        whereArgs: [stock['id']],
      );
    } catch (e) {
      print('SQFliteDbService updateStock: $e');
    }
  }

  Future<void> deleteStock(Map<String, dynamic> stock) async {
    try {
      await sqflitePackage.deleteDatabase(path);
      print('Database successfully deleted.');
    } catch (e) {
      print('SQFliteDbService deleteStock: $e');
    }
  }
}
