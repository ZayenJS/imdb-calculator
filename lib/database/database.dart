import 'package:flutter/foundation.dart';
import 'package:ironmaster_dumbbell_calculator/models/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const _databaseName = "imdbc.db";
  static const _databaseVersion = 1;

  static Database? _database;

  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppDatabase._databaseName);
    return openDatabase(
      path,
      version: AppDatabase._databaseVersion,
      onCreate: (db, version) async {
        if (version == 1) {
          await Settings.createTable();
          await Settings(
            has120lbsAddOn: false,
            has165lbsAddOn: false,
            hasHeavyHandleKit: false,
          ).insert();
        }
      },
      onOpen: (db) async {
        if (kDebugMode) {
          print("Database opened.");
        }
      },
    );
  }
}
