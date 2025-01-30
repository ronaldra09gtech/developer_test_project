import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:developer_test_project/core/database_helper.dart';
import 'package:developer_test_project/models/event_model.dart';

void main() {
  late DatabaseHelper dbHelper;

  setUp(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    dbHelper = DatabaseHelper.instance;
    await dbHelper.database;
  });

  tearDown(() async {
    final db = await dbHelper.database;
    await db.close();
  });

  test('Insert and retrieve an event', () async {
    final event = Event(button: 'Button 1', timestamp: '2024-01-01 12:00:00');

    await dbHelper.insertEvent(event);
    final events = await dbHelper.getEvents();

    expect(events.length, 1);
    expect(events.first.button, 'Button 1');
  });

  test('Insert multiple events and verify order', () async {
    final event1 = Event(button: 'Button 2', timestamp: '2024-01-01 12:00:00');
    final event2 = Event(button: 'Button 3', timestamp: '2024-01-02 13:00:00');

    await dbHelper.insertEvent(event1);
    await dbHelper.insertEvent(event2);

    final events = await dbHelper.getEvents();
    expect(events.length, 2);
    expect(events.first.button, 'Button 3');
  });
}
