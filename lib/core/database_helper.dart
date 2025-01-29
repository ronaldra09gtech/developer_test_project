import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/event_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'events.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE events(id INTEGER PRIMARY KEY AUTOINCREMENT, button TEXT, timestamp TEXT)',
        );
      },
    );
  }

  Future<void> insertEvent(Event event) async {
    final db = await database;
    await db.insert('events', event.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Event>> getEvents() async {
    final db = await database;
    final result = await db.query('events', orderBy: 'timestamp DESC');
    return result.map((json) => Event.fromMap(json)).toList();
  }
}
