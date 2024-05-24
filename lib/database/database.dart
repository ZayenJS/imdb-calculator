import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ironmaster_dumbbell_calculator/models/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const _databaseName = "imdbc.db";
  static Database? _database;

  static Future<Database> getDb() {
    if (_database == null) {
      return AppDatabase().initializeDatabase();
    }

    return Future.value(_database!);
  }

  Future<Database> initializeDatabase() async {
    if (_database != null) return _database!;

    WidgetsFlutterBinding.ensureInitialized();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppDatabase._databaseName);

    return openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        if (kDebugMode) {
          print("Database opened.");
        }
      },
    );
  }

  Future setup() async {
    await Settings.createTable();
    await Settings.get();
  }
}
