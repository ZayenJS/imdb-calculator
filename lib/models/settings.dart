import 'dart:io';

import 'package:ironmaster_dumbbell_calculator/database/database.dart';
import 'package:sqflite/sqflite.dart';

class Settings {
  int id;
  bool has120lbsAddOn;
  bool has165lbsAddOn;
  bool hasHeavyHandleKit;

  Settings({
    this.id = 1,
    this.has120lbsAddOn = false,
    this.has165lbsAddOn = false,
    this.hasHeavyHandleKit = false,
  });

  static createTable() async {
    const String query = '''
      CREATE TABLE IF NOT EXISTS settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        has_120lbs_add_on INTEGER DEFAULT 0,
        has_165lbs_add_on INTEGER DEFAULT 0,
        has_heavy_handle_kit INTEGER DEFAULT 0,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''';

    final Database? db = await AppDatabase.instance.database;

    if (!db!.isOpen) {
      print("Database was not opened.");
      exit(1);
    }

    db.execute(query);
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      has120lbsAddOn: map['has_120lbs_add_on'] == 1,
      has165lbsAddOn: map['has_165lbs_add_on'] == 1,
      hasHeavyHandleKit: map['has_heavy_handle_kit'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'has_120lbs_add_on': has120lbsAddOn,
      'has_165lbs_add_on': has165lbsAddOn,
      'has_heavy_handle_kit': hasHeavyHandleKit,
    };
  }

  Map<String, dynamic> toInsertableMap() {
    return {
      'id': id,
      'has_120lbs_add_on': has120lbsAddOn ? 1 : 0,
      'has_165lbs_add_on': has165lbsAddOn ? 1 : 0,
      'has_heavy_handle_kit': hasHeavyHandleKit ? 1 : 0,
    };
  }

  Future<void> insert() async {
    final Database? db = await AppDatabase.instance.database;

    if (!db!.isOpen) {
      print("Database was not opened.");
      exit(1);
    }

    await db.insert(
      'settings',
      toInsertableMap(),
    );
  }

  Future<void> update() async {
    final Database? db = await AppDatabase.instance.database;

    if (!db!.isOpen) {
      print("Database was not opened.");
      exit(1);
    }

    await db.update(
      'settings',
      toInsertableMap(),
    );
  }

  static Future<Settings> get() async {
    final Database? db = await AppDatabase.instance.database;

    if (!db!.isOpen) {
      print("Database was not opened.");
      exit(1);
    }

    List<Map<String, dynamic>> maps = await db.query('settings');

    if (maps.isEmpty) {
      return Settings();
    }

    return Settings.fromMap(maps.first);
  }
}
