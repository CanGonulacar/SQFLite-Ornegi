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
    //version çağırılırsa [onCreate], [onUpgrade] ve [onDowngrade] properties çalışır.
    //openDatabase çağırılmadan önce veritabanı mevcut değilse onCreate çalışır.
    //[onUpgrade] aşağıdaki koşullardan biri karşılanırsa çağrılır:
    /*onUpgrade onCreate gibi Database ve version için int değeri alır.
    ekstra olarak bir tane daha int değer alır. Yeni bir database oluşturmaya yarar.
    Peki neden ihtiyaç duyarız. Olurda farklı bir Database'e geçecekseniz
    bu property ile farklı şemayı işlemek için gerekli geçiş prosedürlerini gerçekleştirebilirsiniz veya
    2 farklı database tutmak ta isteyebilirsiniz.*/
    //[ReadOnly] (varsayılan olarak false) true olduğunda, diğer tüm parametreler yok sayılır ve veritabanı olduğu gibi açılır
    //[onOpen], çağrılacak son isteğe bağlı geri aramadır(function). Veritabanı sürümü ayarlandıktan sonra ve [openDatabase] dönmeden önce çağrılır.
    //[singleInstance] true olduğunda (varsayılan), belirli bir yol için tek bir veritabanı örneği döndürülür. Aynı yolla [openDatabase]'e yapılan sonraki çağrılar aynı örneği döndürür ve bu çağrı için geri çağrılar gibi tüm diğer parametreleri atar.
    //[onDownGrade] yeni versiyonlu dan eski versiyona etkileşime girecekse ortaya çıkar. Bu senaryodan kaçılması önerilir.

    var path = await openDatabase(
      join(await getDatabasesPath(), 'person.db'),
      version: 1,
      onCreate: _onCreate,
    );
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

  //View
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
