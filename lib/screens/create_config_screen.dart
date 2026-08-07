// lib/screens/import_config_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/file_manager_service.dart';
import '../models/config_model.dart';

class ImportConfigScreen extends StatefulWidget {
  const ImportConfigScreen({super.key});

  @override
  State<ImportConfigScreen> createState() => _ImportConfigScreenState();
}

class _ImportConfigScreenState extends State<ImportConfigScreen> {
  final FileManagerService _fileManager = FileManagerService();
  bool _isLoading = false;
  String? _importedName;
  String? _importedNote;
  String? _importedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Config'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_upload,
              size: 80,
              color: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 20),
            const Text(
              'Import .abde Config File',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select an .abde file from your device',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            if (_isLoading)
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              )
            else
              Column(
                children: [
                  if (_importedName != null) ...[
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.check_circle,
                                    color: Colors.green),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _importedName!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (_importedNote != null &&
                                _importedNote!.isNotEmpty)
                              Text(
                                _importedNote!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            const SizedBox(height: 8),
                            Chip(
                              label: Text(_importedType ?? 'Unknown'),
                              backgroundColor: Colors.deepPurple.shade100,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _importFile,
                            icon: const Icon(Icons.file_open),
                            label: const Text('Choose Another'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (_importedName != null) {
                                Navigator.pop(context, true);
                              }
                            },
                            icon: const Icon(Icons.check),
                            label: const Text('Import'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    ElevatedButton.icon(
                      onPressed: _importFile,
                      icon: const Icon(Icons.folder_open),
                      label: const Text('Select .abde File'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ],
              ),
            const SizedBox(height: 30),
            if (_importedName == null && !_isLoading)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info, color: Colors.amber),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Supported file format: .abde\n'
                        'Created by CONFIGES ABDELLALI PRO',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _importFile() async {
    try {
      setState(() {
        _isLoading = true;
        _importedName = null;
        _importedNote = null;
        _importedType = null;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['abde'],
      );

      if (result == null || result.files.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final filePath = result.files.first.path;
      if (filePath == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final isValid = await _fileManager.isValidABDE(filePath);
      if (!isValid) {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar('Invalid .abde file or corrupted!', Colors.red);
        return;
      }

      final config = await _fileManager.importABDE(filePath);
      if (config == null) {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar('Failed to import config!', Colors.red);
        return;
      }

      setState(() {
        _isLoading = false;
        _importedName = config.name;
        _importedNote = config.note;
        _importedType = config.type;
      });

      _showSnackBar('Config imported successfully!', Colors.green);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error: $e', Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
