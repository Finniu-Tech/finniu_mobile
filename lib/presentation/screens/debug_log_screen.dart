import 'package:finniu/utils/debug_logger.dart';
import 'package:flutter/material.dart';

class DebugLogsScreen extends StatefulWidget {
  @override
  _DebugLogsScreenState createState() => _DebugLogsScreenState();
}

class _DebugLogsScreenState extends State<DebugLogsScreen> {
  String _logs = '';

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    final logs = await DebugLogger.getLogs();
    setState(() {
      _logs = logs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debug Logs'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadLogs,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await DebugLogger.clearLogs();
              await _loadLogs();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(_logs),
        ),
      ),
    );
  }
}
