// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../core/database_helper.dart';
import '../models/event_model.dart';
import 'event_log_screen.dart';
import '../widgets/event_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  void _onButtonPressed(String button) async {
    await dbHelper.insertEvent(Event(button: button, timestamp: DateTime.now().toString()));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$button pressed')));
    }
  }

  void _navigateToLogs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EventLogScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Logger')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 1; i <= 4; i++)
            EventButton(
              buttonText: 'Button $i',
              onPressed: () => _onButtonPressed('Button $i'),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _navigateToLogs,
            child: const Text('View Logs'),
          ),
        ],
      ),
    );
  }
}
