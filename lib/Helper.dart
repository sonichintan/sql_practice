import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Student.dart';

class Helper {
  static final _dataBaseName = "student.db";
  static final _dataBaseVersion = 1;
  static final table = "student";
  static final colId = 'id';
  static final colName = 'name';
  static final colAge = 'age';

  Helper.privateConstructor();

  static final Helper instance = Helper.privateConstructor();

  static Database _database;


  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dataBaseName);
    return await openDatabase(path,
        version: _dataBaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $table($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT NOT NULL,$colAge INTEGER NOT NULL)''');
  }

  Future<int> insert(Student student) async {
    Database db = await instance.database;
    return await db.insert(table, {'name': student.name, 'age': student.age});
  }

  Future<List<Map<String, dynamic>>> getAlldata() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> search(name) async {
    Database db = await instance.database;
    return await db.query(table,where: "$colName LIKE '%$name%'");
  }
  Future<int> update(Student student) async {
    Database db = await instance.database;
    int id = student.toMap()['id'];
    return await db.update(table,student.toMap(),where: '$colId=?',whereArgs: [id]);
  }
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table,where: "$colId = ?",whereArgs: [id]);
  }

}
