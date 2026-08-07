// lib/screens/my_configs_screen.dart

import 'package:flutter/material.dart';
import '../services/file_manager_service.dart';
import '../models/config_model.dart';
import 'create_config_screen.dart';
import 'import_config_screen.dart';

class MyConfigsScreen extends StatefulWidget {
  const MyConfigsScreen({super.key});

  @override
  State<MyConfigsScreen> createState() => _MyConfigsScreenState();
}

class _MyConfigsScreenState extends State<MyConfigsScreen> {
  final FileManagerService _fileManager = FileManagerService();
  List<ConfigModel> _configs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConfigs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadConfigs();
  }

  Future<void> _loadConfigs() async {
    setState(() {
      _isLoading = true;
    });
    final configs = await _fileManager.loadAllConfigs();
    setState(() {
      _configs = configs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Configs'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadConfigs,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
            )
          : _configs.isEmpty
              ? _buildEmptyState()
              : _buildConfigsList(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ImportConfigScreen(),
                ),
              );
              if (result == true) {
                _loadConfigs();
              }
            },
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            child: const Icon(Icons.file_download),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              final config = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateConfigScreen(),
                ),
              );
              if (config != null) {
                await _fileManager.saveConfigAsABDE(config);
                _loadConfigs();
              }
            },
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 80,
            color: Colors.deepPurple.shade300,
          ),
          const SizedBox(height: 20),
          const Text(
            'No Configs Found',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Create a new config or import .abde file',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () async {
              final config = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateConfigScreen(),
                ),
              );
              if (config != null) {
                await _fileManager.saveConfigAsABDE(config);
                _loadConfigs();
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Config'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _configs.length,
      itemBuilder: (context, index) {
        final config = _configs[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getTypeIcon(config.type),
                      color: Colors.deepPurple,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            config.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (config.note.isNotEmpty)
                            Text(
                              config.note,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Chip(
                      label: Text(
                        _getTypeLabel(config.type),
                        style: const TextStyle(fontSize: 12),
                      ),
                      backgroundColor: _getTypeColor(config.type),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Created: ${_formatDate(config.createdAt)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.share, size: 20),
                      onPressed: () => _shareConfig(config),
                      color: Colors.blue,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () => _deleteConfig(config),
                      color: Colors.red,
                    ),
                    IconButton(
                      icon: const Icon(Icons.open_in_new, size: 20),
                      onPressed: () => _openConfig(config),
                      color: Colors.deepPurple,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      config.isActive ? Icons.circle : Icons.circle_outlined,
                      color: config.isActive ? Colors.green : Colors.grey,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      config.isActive ? 'Active' : 'Inactive',
                      style: TextStyle(
                        fontSize: 12,
                        color: config.isActive ? Colors.green : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: Icon(
                        config.isFavorite ? Icons.star : Icons.star_border,
                        color: config.isFavorite ? Colors.amber : Colors.grey,
                        size: 20,
                      ),
                      onPressed: () => _toggleFavorite(config),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'ssh':
        return Icons.terminal;
      case 'v2ray':
        return Icons.vpn_key;
      case 'http':
        return Icons.http;
      case 'slowdns':
        return Icons.dns;
      case 'udp':
        return Icons.wifi;
      default:
        return Icons.settings;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'ssh':
        return 'SSH';
      case 'v2ray':
        return 'V2Ray';
      case 'http':
        return 'HTTP';
      case 'slowdns':
        return 'SlowDNS';
      case 'udp':
        return 'UDP';
      default:
        return 'Unknown';
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'ssh':
        return Colors.blue.shade100;
      case 'v2ray':
        return Colors.green.shade100;
      case 'http':
        return Colors.orange.shade100;
      case 'slowdns':
        return Colors.purple.shade100;
      case 'udp':
        return Colors.teal.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _shareConfig(ConfigModel config) async {
    final success = await _fileManager.shareConfig(config);
    if (success) {
      _showSnackBar('Config shared successfully!', Colors.green);
    } else {
      _showSnackBar('Failed to share config', Colors.red);
    }
  }

  Future<void> _deleteConfig(ConfigModel config) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Config'),
        content: Text('Are you sure you want to delete "${config.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await _fileManager.deleteConfig(config.id);
      if (success) {
        _loadConfigs();
        _showSnackBar('Config deleted', Colors.green);
      } else {
        _showSnackBar('Failed to delete config', Colors.red);
      }
    }
  }

  void _openConfig(ConfigModel config) {
    // TODO: Open config details/connect
    _showSnackBar('Opening ${config.name}...', Colors.blue);
  }

  Future<void> _toggleFavorite(ConfigModel config) async {
    final updated = config.copyWith(isFavorite: !config.isFavorite);
    await _fileManager.saveConfigAsABDE(updated);
    _loadConfigs();
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
