import 'package:flutter_yoga_app/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class YogaDatabase {
  static final YogaDatabase instance = YogaDatabase._init();
  static Database? _database;
  YogaDatabase._init();

  Future<Database> _initalizeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initalizeDB("YogaStepsDB.db");
    return _database;
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    //id, bool(second), text

    await db.execute('''
    CREATE TABLE ${YogaModel.YogaTable1}(
    ${YogaModel.IDName} $idType,
    ${YogaModel.YogaName} $textType,
    ${YogaModel.ImageName} $textType,
    ${YogaModel.SecondsOrTimes} $textType,
    ${YogaModel.SecondsOrNot} $boolType
    )
    ''');

    await db.execute('''
    CREATE TABLE ${YogaModel.YogaTable2}(
    ${YogaModel.IDName} $idType,
    ${YogaModel.YogaName} $textType,
    ${YogaModel.ImageName} $textType,
    ${YogaModel.SecondsOrTimes} $textType,
    ${YogaModel.SecondsOrNot} $boolType
    )''');

    await db.execute('''
    CREATE TABLE ${YogaModel.YogaTable3}(
    ${YogaModel.IDName} $idType,
    ${YogaModel.YogaName} $textType,
    ${YogaModel.ImageName} $textType,
    ${YogaModel.SecondsOrTimes} $textType,
    ${YogaModel.SecondsOrNot} $boolType
    )''');

    await db.execute('''
    CREATE TABLE ${YogaModel.YogaSummary}(
    ${YogaModel.IDName} $idType,
    ${YogaModel.YogaWorkOutName} $textType,
    ${YogaModel.BackImg} $textType,
    ${YogaModel.TimeTaken} $textType,
    ${YogaModel.TotalNoOfWorkout} $textType
    )''');
  }

  // To insert Data Into Database
  Future<Yoga?> Insert(Yoga yoga, String tableName) async {
    final db = await instance.database;
    final id = await db!.insert(tableName, yoga.toJson());

    return yoga.copy(id: id);
  }

  Future<YogaSummary?> InsertYogaSum(YogaSummary yogaSummary) async {
    final db = await instance.database;
    final id = await db!.insert(YogaModel.YogaSummary, yogaSummary.toJson());

    return yogaSummary.copy(id: id);
  }

  Future<List<YogaSummary>> readAllYogaSum() async {
    final db = await instance.database;
    final orderBy = '${YogaModel.IDName} ASC';
    final query_res = await db!.query(YogaModel.YogaSummary, orderBy: orderBy);

    return query_res.map((json) => YogaSummary.fromJson(json)).toList();
  }

  Future<List<Yoga>> readAllYoga(String tableName) async {
    final db = await instance.database;
    final orderBy = '${YogaModel.IDName} ASC';
    final query_res = await db!.query(tableName, orderBy: orderBy);

    return query_res.map((json) => Yoga.fromJson(json)).toList();
  }

  Future<Yoga?> readOneYoga(int id, String tableName) async {
    final db = await instance.database;
    final map = await db!.query(tableName,
        columns: YogaModel.YogaTable1ColumnName,
        where: '${YogaModel.IDName} = ?',
        whereArgs: [id]);

    if (map.isNotEmpty) {
      return Yoga.fromJson(map.first);
    } else {
      return null;
    }
  }
}
