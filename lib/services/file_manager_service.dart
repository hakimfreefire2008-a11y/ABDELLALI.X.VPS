// lib/services/file_manager_service.dart

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/config_model.dart';
import 'encryption_service.dart';

class FileManagerService {
  static final FileManagerService _instance = FileManagerService._internal();
  factory FileManagerService() => _instance;
  FileManagerService._internal();

  final EncryptionService _encryption = EncryptionService();

  // Get app documents directory
  Future<Directory> _getAppDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final configsDir = Directory('${appDir.path}/configs');
    if (!await configsDir.exists()) {
      await configsDir.create(recursive: true);
    }
    return configsDir;
  }

  // Get downloads directory
  Future<Directory?> _getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      final downloads = Directory('/storage/emulated/0/Download');
      if (await downloads.exists()) {
        return downloads;
      }
    }
    return await getExternalStorageDirectory();
  }

  // Save config as .abde file
  Future<String?> saveConfigAsABDE(ConfigModel config) async {
    try {
      final dir = await _getAppDirectory();
      final fileName = '${config.name.replaceAll(RegExp(r'[^\w\s-]'), '')}.abde';
      final file = File('${dir.path}/$fileName');

      // Convert config to JSON
      final configJson = config.toJson();

      // Encrypt the JSON
      final encrypted = _encryption.encryptConfig(configJson);

      // Generate signature
      final signature = _encryption.generateSignature(encrypted);

      // Create file content with signature
      final fileData = {
        'data': encrypted,
        'signature': signature,
        'version': '1.0',
        'createdAt': DateTime.now().toIso8601String(),
      };

      final jsonContent = json.encode(fileData);
      await file.writeAsString(jsonContent);

      return file.path;
    } catch (e) {
      return null;
    }
  }

  // Import .abde file
  Future<ConfigModel?> importABDE(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return null;

      final content = await file.readAsString();
      final jsonData = json.decode(content) as Map<String, dynamic>;

      // Verify signature
      final encryptedData = jsonData['data'] as String;
      final signature = jsonData['signature'] as String;

      if (!_encryption.verifySignature(encryptedData, signature)) {
        throw Exception('File signature verification failed!');
      }

      // Decrypt data
      final configData = _encryption.decryptConfig(encryptedData);
      if (configData.isEmpty) {
        throw Exception('Failed to decrypt config data');
      }

      // Create config model
      final config = ConfigModel.fromJson(configData);

      // Save to local configs
      await _saveConfigLocal(config);

      return config;
    } catch (e) {
      return null;
    }
  }

  // Save config locally (encrypted)
  Future<void> _saveConfigLocal(ConfigModel config) async {
    final dir = await _getAppDirectory();
    final fileName = '${config.id}.abde';
    final file = File('${dir.path}/$fileName');

    final configJson = config.toJson();
    final encrypted = _encryption.encryptConfig(configJson);
    final signature = _encryption.generateSignature(encrypted);

    final fileData = {
      'data': encrypted,
      'signature': signature,
      'version': '1.0',
      'createdAt': DateTime.now().toIso8601String(),
    };

    await file.writeAsString(json.encode(fileData));
  }

  // Load all saved configs
  Future<List<ConfigModel>> loadAllConfigs() async {
    final List<ConfigModel> configs = [];
    try {
      final dir = await _getAppDirectory();
      final files = dir.listSync();

      for (var file in files) {
        if (file is File && file.path.endsWith('.abde')) {
          try {
            final content = await file.readAsString();
            final jsonData = json.decode(content) as Map<String, dynamic>;
            final encryptedData = jsonData['data'] as String;

            // Decrypt
            final configData = _encryption.decryptConfig(encryptedData);
            if (configData.isNotEmpty) {
              final config = ConfigModel.fromJson(configData);
              configs.add(config);
            }
          } catch (e) {
            continue;
          }
        }
      }
    } catch (e) {
      return configs;
    }

    // Sort by createdAt
    configs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return configs;
  }

  // Delete config file
  Future<bool> deleteConfig(String configId) async {
    try {
      final dir = await _getAppDirectory();
      final fileName = '$configId.abde';
      final file = File('${dir.path}/$fileName');
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Share .abde file
  Future<bool> shareConfig(ConfigModel config) async {
    try {
      final filePath = await saveConfigAsABDE(config);
      if (filePath == null) return false;

      final file = File(filePath);
      if (!await file.exists()) return false;

      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'Share this config via CONFIGES ABDELLALI PRO',
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // Export to downloads folder
  Future<bool> exportToDownloads(ConfigModel config) async {
    try {
      final downloadsDir = await _getDownloadsDirectory();
      if (downloadsDir == null) return false;

      final fileName = '${config.name.replaceAll(RegExp(r'[^\w\s-]'), '')}.abde';
      final destFile = File('${downloadsDir.path}/$fileName');

      // Save config
      final sourcePath = await saveConfigAsABDE(config);
      if (sourcePath == null) return false;

      final sourceFile = File(sourcePath);
      await sourceFile.copy(destFile.path);

      return true;
    } catch (e) {
      return false;
    }
  }

  // Check if file is valid .abde
  Future<bool> isValidABDE(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return false;
      if (!filePath.endsWith('.abde')) return false;

      final content = await file.readAsString();
      final jsonData = json.decode(content) as Map<String, dynamic>;

      if (!jsonData.containsKey('data') || !jsonData.containsKey('signature')) {
        return false;
      }

      final encryptedData = jsonData['data'] as String;
      final signature = jsonData['signature'] as String;

      return _encryption.verifySignature(encryptedData, signature);
    } catch (e) {
      return false;
    }
  }

  // Get file info
  Future<Map<String, dynamic>?> getFileInfo(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return null;

      final stat = await file.stat();
      return {
        'name': file.path.split('/').last,
        'size': stat.size,
        'modified': stat.modified,
        'path': file.path,
      };
    } catch (e) {
      return null;
    }
  }
}
