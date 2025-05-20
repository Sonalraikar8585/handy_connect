// db/database_helper.dart
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../models/service_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'handyconnect.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        role TEXT NOT NULL,
        phone TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE service_providers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        service TEXT NOT NULL,
        phone TEXT NOT NULL UNIQUE,
        location TEXT NOT NULL
      )
    ''');
  }

  // Insert user
  Future<int> insertUser(User user) async {
    final dbClient = await db;
    return await dbClient.insert('users', user.toMap());
  }

  // Insert provider
  Future<int> insertProvider(ServiceProvider provider) async {
    final dbClient = await db;
    return await dbClient.insert('service_providers', provider.toMap());
  }

  // Check if user phone exists
  Future<bool> checkUserPhone(String phone) async {
    final dbClient = await db;
    var res = await dbClient.query('users',
        where: 'phone = ?', whereArgs: [phone], limit: 1);
    return res.isNotEmpty;
  }

  // Check if provider phone exists
  Future<bool> checkProviderPhone(String phone) async {
    final dbClient = await db;
    var res = await dbClient.query('service_providers',
        where: 'phone = ?', whereArgs: [phone], limit: 1);
    return res.isNotEmpty;
  }
}
