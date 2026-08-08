import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/config_model.dart';
import '../services/file_manager_service.dart';

class ImportConfigScreen extends StatefulWidget {
  const ImportConfigScreen({super.key});

  @override
  State<ImportConfigScreen> createState() => _ImportConfigScreenState();
}

class _ImportConfigScreenState extends State<ImportConfigScreen> {
  final FileManagerService _fileManager = FileManagerService();

  ConfigModel? _importedConfig;
  String? _importedType;

  bool _loading = false;
  String? _error;

  Future<void> _pickFile() async {
    setState(() {
      _loading = true;
      _error = null;
      _importedConfig = null;
      _importedType = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['abde'],
      );

      if (result == null || result.files.single.path == null) {
        setState(() {
          _loading = false;
        });
        return;
      }

      final filePath = result.files.single.path!;

      final isValid = await _fileManager.isValidABDE(filePath);

      if (!isValid) {
        setState(() {
          _loading = false;
          _error = 'هذا الملف ليس ملف ABDE صالحاً.';
        });
        return;
      }

      final config = await _fileManager.importABDE(filePath);

      if (config == null) {
        setState(() {
          _loading = false;
          _error = 'تعذر قراءة ملف الكونفيج.';
        });
        return;
      }

      setState(() {
        _importedConfig = config;
        _importedType = config.type;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'حدث خطأ أثناء استيراد الملف.';
      });
    }
  }

  void _useConfig() {
    if (_importedConfig == null) {
      return;
    }

    Navigator.pop(context, _importedConfig);
  }

  @override
  Widget build(BuildContext context) {
    final config = _importedConfig;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Config'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.25),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.file_open_rounded,
                      size: 70,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Import ABDE Config',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'اختر ملف .abde لاستيراد الكونفيج',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _loading ? null : _pickFile,
                        icon: const Icon(Icons.folder_open),
                        label: const Text('اختيار ملف ABDE'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                ),

              if (_error != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              if (config != null) ...[
                const SizedBox(height: 10),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Config Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        _infoRow(
                          'Name',
                          config.name,
                        ),

                        _infoRow(
                          'Type',
                          _importedType ?? 'Unknown',
                        ),

                        _infoRow(
                          'Host',
                          config.host,
                        ),

                        _infoRow(
                          'Port',
                          config.port,
                        ),

                        if (config.sni.isNotEmpty)
                          _infoRow(
                            'SNI',
                            config.sni,
                          ),

                        if (config.v2rayType.isNotEmpty)
                          _infoRow(
                            'V2Ray',
                            config.v2rayType,
                          ),

                        if (config.nsDomain.isNotEmpty)
                          _infoRow(
                            'NS Domain',
                            config.nsDomain,
                          ),

                        if (config.note.isNotEmpty)
                          _infoRow(
                            'Note',
                            config.note,
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _useConfig,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('استخدام هذا الكونفيج'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 95,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
            ),
          ),
        ],
      ),
    );
  }
}
