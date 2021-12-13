import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testler/models/person.dart';

class DBHelper {
  DBHelper._();
  static final instance = DBHelper._();

  static Database? _database;

  Future<Database> get database async => _database ?? await _initDb();

  Future<Database> _initDb() async {
    var path = await openDatabase(join(await getDatabasesPath(), 'person.db'),
        version: 1, onCreate: _onCreate);
    return path;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Person (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ad TEXT,
        sehir TEXT,
        yas INTEGER
      )
    ''');
  }

  Future<List<Person>> getPerson() async {
    var db = await instance.database;
    var person = await db.query('Person');
    List<Person> personList =
        person.isNotEmpty ? person.map((e) => Person.fromMap(e)).toList() : [];
    return personList;
  }

  Future<void> add(Person p) async {
    var db = await instance.database;
    await db.insert('Person', p.toMap());
  }

  Future<int> delete(int i) async {
    var db = await instance.database;
    return await db.delete('Person', where: 'id =$i');
  }

  Future<int> update(Person p) async {
    var db = await instance.database;
    return await db
        .update('Person', p.toMap(), where: 'id = ?', whereArgs: [p.id]);
  }

  Future<List<Person>> search(String k) async {
    final db = await instance.database;
    List<Map<String, dynamic>> allRows =
        await db.query('Person', where: 'ad LIKE ?', whereArgs: ['%$k%']);
    return allRows.isNotEmpty
        ? allRows.map((e) => Person.fromMap(e)).toList()
        : [];
  }
}
