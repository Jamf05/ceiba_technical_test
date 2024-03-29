import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:ceiba_technical_test/core/env.dart';
import 'package:ceiba_technical_test/core/utils/database_utils.dart';
import 'package:ceiba_technical_test/core/utils/update_application_utils.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SchemaDB {
  static const userName = 'user';
  static const userTable = ''' 
    CREATE TABLE IF NOT EXISTS user (
      id INTEGER PRIMARY KEY NOT NULL,
      name TEXT NOT NULL,
      username TEXT NOT NULL,
      email TEXT NOT NULL,
      phone TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  ''';
  static final tables = {
    userName: userTable,
  };

  static final toMigrate = [
    userName,
  ];

  static final toRebuild = [];

  static final excludeTables = [
    "android_metadata",
    "sqlite_sequence",
  ];
}

class DatabaseHelper {
  static const _databaseName = "ceiba_technical_test.db";
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  late Database _database;

  static Future<DatabaseHelper> init() async {
    _instance._database = await _instance._initDatabase();
    return _instance;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    final databaseVersion = UpdateApplicationUtils.appVersionToInt(Env.version);
    Database database = await openDatabase(path,
        version: databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onDowngrade: _onDowngrade);
    return database;
  }

  static Future<void> deleteDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    await databaseFactory.deleteDatabase(path);
  }

  Future<void> _onCreate(Database db, int version) async {
    log("Create DB, version: $version", name: "INSERTDB");
    for (var item in SchemaDB.tables.values.toList()) {
      await db.execute(item);
    }
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    log("${table.toString()}, ${values.toString()}", name: "INSERTDB");
    Database? db = _instance._database;
    int? id = await db.insert(table, values);
    return id;
  }

  Future<List<Map<dynamic, dynamic>>?> select(String table,
      {List<String>? cols,
      String? where,
      List<dynamic>? whereArgs,
      String? orderBy,
      int? limit}) async {
    Database? db = _instance._database;
    log("${table.toString()}, ${cols.toString()}, ${where.toString()}",
        name: "SELECTDB");
    List<Map>? maps = await db.query(table,
        columns: cols,
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit);
    return maps;
  }

  Future<void> update(String table, Map<String, dynamic> values, String where,
      List<dynamic> whereArgs) async {
    Database? db = _database;
    log("${table.toString()}, ${values.toString()}, ${where.toString()}",
        name: "UPDATEDB");
    final res =
        await db.update(table, values, where: where, whereArgs: whereArgs);
    log("$res", name: "UPDATEDB-RES");
  }

  Future<void> execute(String? sql, {Database? db}) async {
    log(sql ?? "", name: "EXECUTEDB");
    Database? db_ = db ?? _database;
    await db_.execute(sql ?? "");
  }

  Future<void> delete(String table, {Database? db}) async {
    String sql = "DROP TABLE IF EXISTS $table;";
    Database? db_ = db ?? _database;
    await db_.execute(sql);
    log(sql, name: "DELETEDB");
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    log("form $oldVersion to $newVersion", name: "DBVersion-set");
    log("======== OnUpgradeDB ========", name: "DB");
    double oldV = oldVersion / 10;
    double newV = newVersion / 10;
    int difference = (oldV.truncate() - newV.truncate()).abs();
    if (difference == 0) {
    } else if (difference >= 1) {
      await _onUpgradeQuery(db, newVersion);
    } else if (difference >= 10) {
      await _onUpgradeQuery(db, newVersion);
    }
  }

  Future<void> _onUpgradeQuery(Database db, int version) async {
    if (!await _doMigration(db)) await _clearAllTable(db);
    log("Upgrade DB, version: $version", name: "DB");
    // String table = '''
    // ''';

    // await db.execute(table);
    await _onCreate(db, version);
  }

  FutureOr<void> _onDowngrade(
      Database db, int oldVersion, int newVersion) async {
    log("form $oldVersion to $newVersion", name: "DBVersion-set");
    log("======== onDowngrade ========", name: "DB");
    double oldV = oldVersion / 10;
    double newV = newVersion / 10;
    int difference = (oldV.truncate() - newV.truncate()).abs();
    if (difference == 0) {
    } else if (difference >= 1) {
      await _onDowngradeQuery(db, newVersion);
    } else if (difference >= 10) {
      await _onDowngradeQuery(db, newVersion);
    }
  }

  Future<void> _onDowngradeQuery(Database db, int version) async {
    if (!await _doMigration(db)) await _clearAllTable(db);
    log("Downgrade DB, version: $version", name: "DB");
    // String table = '''
    // ''';

    // await db.execute(table);
    await _onCreate(db, version);
  }

  Future<void> _clearAllTable(Database db) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();

    List<String> tableNames = (await db
            .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
        .map((row) => row['name'].toString())
        .toList();

    for (var t in SchemaDB.excludeTables) {
      tableNames.remove(t);
    }
    for (var item in tableNames) {
      try {
        await delete(item, db: db);
      } catch (e) {
        continue;
      }
    }
  }

  Future<bool> _doMigration(Database db) async {
    for (var t in SchemaDB.toMigrate) {
      try {
        final r = await db
            .rawQuery("SELECT sql FROM sqlite_master WHERE name = '$t'");
        if (r.isEmpty) {
          log("MIGRATION FAILED", name: "DB");
          return false;
        }
        if (!r.first.containsKey("sql")) {
          log("MIGRATION FAILED", name: "DB");
          return false;
        }
        if (!DatabaseUtils.schemaCompare(
            r.first["sql"].toString(), SchemaDB.tables[t])) {
          log("MIGRATION FAILED", name: "DB");
          return false;
        }
      } catch (e) {
        log("MIGRATION FAILED", name: "DB");
        return false;
      }
    }

    for (var item in SchemaDB.toRebuild) {
      try {
        await delete(item, db: db);
        await execute(SchemaDB.tables[item], db: db);
      } catch (e) {
        log("MIGRATION FAILED", name: "DB");
        return false;
      }
    }

    log("SUCCESSFUL MIGRATION", name: "DB");
    return true;
  }
}
