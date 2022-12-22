import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:your_friends/model/contact_model.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  final String _db = "CONTACT_DB";
  final String _table = "CONTACT_TABLE";
  final String _colId = "id";
  final String _colName = "name";
  final String _colMobile = "mobile";
  final String _colEmail = "email";
  final String _colFavorite = "favorite";
  final int _version = 1;

  String _pathDatabase = "";

  String get pathDatabase => _pathDatabase;

  Future<Database> get database async {
    return _database ??= await initDatabase();
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    _pathDatabase = "${directory.path}/$_db.db";

    var database = await openDatabase(_pathDatabase,
        version: _version, onCreate: _createDatabase);

    return database;
  }

  Future<void> _createDatabase(Database db, int version) async {
    // await db.execute(
    //     "CREATE TABLE $_table ($_colId INTEGER PRIMARY KEY AUTOINCREMENT, $_colName TEXT, $_colMobile TEXT, $_colEmail TEXT, $_colFavorite INTEGER)");
    await db.execute(''' 
    CREATE TABLE $_table (
    $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
    $_colName TEXT,
    $_colMobile TEXT,
    $_colEmail TEXT,
    $_colFavorite INTEGER
    )
   ''');
  }

  Future<int> insert(ContactModel contact) async {
    var db = await database;

    Map<String, Object> insertValue = {
      _colName: contact.name,
      _colMobile: contact.mobileNo,
      _colEmail: contact.email,
      _colFavorite: contact.favorite
    };

    var result = await db.insert(_table, insertValue);
    return result;
  }

  Future<int> delete(int id) async {
    var db = await database;

    var effectRow =
        await db.delete(_table, where: '$_colId = ?', whereArgs: [id]);
    return effectRow;
  }

  Future<int> update(ContactModel model) async {
    var db = await database;
    var effectRow = await db.update(_table, model.toMap(),
        where: '$_colId = ?', whereArgs: [model.id]);
    return effectRow;
  }

  Future<int> updateFavorite(int id, int favorite) async {
    var db = await database;

    var updateValue = {
      _colFavorite: favorite,
    };

    var effectRow = await db
        .update(_table, updateValue, where: '$_colId = ?', whereArgs: [id]);

    return effectRow;
  }

  Future<ContactModel?> getContactById(int id) async {
    var db = await database;

    var contactMap = await db.query(
      _table,
      columns: [_colId, _colName, _colMobile, _colEmail, _colFavorite],
      where: '$_colId = ?',
      whereArgs: [id],
    );

    if (contactMap.isNotEmpty) {
      return ContactModel.fromMap(contactMap.first);
    }

    return null;
  }

  Future<List<ContactModel>> getContacts() async {
    var db = await database;

    List<ContactModel> contacts = [];

    var contactsMap = await db.query(_table,
        columns: [_colId, _colName, _colMobile, _colEmail, _colFavorite]);

    // var contactsMap = await db.rawQuery("SELECT * FROM $_table");

    for (var contact in contactsMap) {
      contacts.add(ContactModel.fromMap(contact));
    }

    return contacts;
  }

  Future<void> close() async {
    var db = await database;
    db.close();
  }
}
