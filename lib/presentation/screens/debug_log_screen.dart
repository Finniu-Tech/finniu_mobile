import 'package:finniu/utils/debug_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  Future<void> _copyLogs() async {
    await Clipboard.setData(ClipboardData(text: _logs));
    // Mostrar un snackbar para confirmar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logs copiados al portapapeles'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debug Logs'),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            tooltip: 'Copiar logs',
            onPressed: _logs.isEmpty ? null : _copyLogs,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Recargar',
            onPressed: _loadLogs,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Limpiar logs',
            onPressed: _logs.isEmpty
                ? null
                : () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Limpiar logs'),
                        content: Text('¿Estás seguro de que quieres eliminar todos los logs?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text('Eliminar'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      await DebugLogger.clearLogs();
                      await _loadLogs();
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Logs eliminados'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
          ),
        ],
      ),
      body: _logs.isEmpty
          ? Center(
              child: Text(
                'No hay logs disponibles',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SelectableText(
                  _logs,
                  style: TextStyle(
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
    );
  }
}
