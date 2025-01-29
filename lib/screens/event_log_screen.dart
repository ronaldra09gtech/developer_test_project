// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../core/database_helper.dart';
import '../models/event_model.dart';

class EventLogScreen extends StatefulWidget {
  const EventLogScreen({super.key});

  @override
  _EventLogScreenState createState() => _EventLogScreenState();
}

class _EventLogScreenState extends State<EventLogScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await dbHelper.getEvents();
    setState(() {
      _events = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Logs')),
      body: _events.isEmpty
          ? const Center(child: Text('No events logged yet'))
          : ListView.builder(
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          return ListTile(
            title: Text('${event.button} pressed'),
            subtitle: Text(event.timestamp),
          );
        },
      ),
    );
  }
}
