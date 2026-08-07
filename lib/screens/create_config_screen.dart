// lib/screens/create_config_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import '../models/config_model.dart';

class CreateConfigScreen extends StatefulWidget {
  const CreateConfigScreen({super.key});

  @override
  State<CreateConfigScreen> createState() => _CreateConfigScreenState();
}

class _CreateConfigScreenState extends State<CreateConfigScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Basic
  String _configName = '';
  String _note = '';
  String _type = 'ssh';
  
  // SSH
  String _sshHost = '';
  String _sshPort = '';
  String _sshUsername = '';
  String _sshPassword = '';
  
  // HTTP
  bool _enablePayload = false;
  String _httpPayload = '';
  bool _enableProxy = false;
  String _httpProxy = '';
  
  // SNI
  bool _enableSni = false;
  String _sniDomain = '';
  
  // V2Ray
  bool _enableV2Ray = false;
  String _v2rayType = 'vless';
  String _v2rayAddress = '';
  String _v2rayPort = '';
  String _v2rayUuid = '';
  String _v2rayHost = '';
  String _v2rayPath = '';
  String _v2raySni = '';
  String _v2rayNetwork = 'tcp';
  String _v2raySecurity = 'none';
  
  // SlowDNS
  bool _enableSlowDNS = false;
  String _slowDnsNsDomain = '';
  String _slowDnsPublicKey = '';
  String _slowDnsDnsIp = '';
  
  // UDP
  bool _enableUDP = false;
  String _udpServer = '';
  String _udpPort = '';
  
  bool _showAdvanced = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Config'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveConfig,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Info
              _buildBasicSection(),
              const SizedBox(height: 20),
              
              // Type Selector
              _buildTypeSelector(),
              const SizedBox(height: 20),
              
              // SSH Fields
              if (_type == 'ssh') _buildSSHSection(),
              
              // HTTP Fields
              if (_type == 'http') _buildHTTPSection(),
              
              // SNI
              _buildSNISection(),
              const SizedBox(height: 20),
              
              // V2Ray
              _buildV2RaySection(),
              const SizedBox(height: 20),
              
              // SlowDNS
              _buildSlowDNSSection(),
              const SizedBox(height: 20),
              
              // UDP
              _buildUDPSection(),
              const SizedBox(height: 20),
              
              // Advanced Settings
              _buildAdvancedToggle(),
              if (_showAdvanced) _buildAdvancedSection(),
              
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveConfig,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Config',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Config Name',
                hintText: 'e.g. INWI-6GB',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter config name';
                }
                return null;
              },
              onSaved: (value) => _configName = value!,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Note',
                hintText: 'Optional note about this config',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 2,
              onSaved: (value) => _note = value ?? '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Config Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _type,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: const [
                DropdownMenuItem(value: 'ssh', child: Text('SSH')),
                DropdownMenuItem(value: 'http', child: Text('HTTP')),
                DropdownMenuItem(value: 'v2ray', child: Text('V2Ray')),
                DropdownMenuItem(value: 'slowdns', child: Text('SlowDNS')),
                DropdownMenuItem(value: 'udp', child: Text('UDP')),
              ],
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSSHSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SSH Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Host',
                hintText: 'ssh.example.com',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.dns),
              ),
              onSaved: (value) => _sshHost = value!,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Port',
                hintText: '22',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.settings_ethernet),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) => _sshPort = value!,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              onSaved: (value) => _sshUsername = value!,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              onSaved: (value) => _sshPassword = value!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHTTPSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HTTP Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Enable Payload'),
              value: _enablePayload,
              onChanged: (value) {
                setState(() {
                  _enablePayload = value;
                });
              },
              activeColor: Colors.deepPurple,
            ),
            if (_enablePayload) ...[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Payload',
                  hintText: 'GET / HTTP/1.1',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onSaved: (value) => _httpPayload = value!,
              ),
              const SizedBox(height: 12),
            ],
            SwitchListTile(
              title: const Text('Enable Proxy'),
              value: _enableProxy,
              onChanged: (value) {
                setState(() {
                  _enableProxy = value;
                });
              },
              activeColor: Colors.deepPurple,
            ),
            if (_enableProxy) ...[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Proxy',
                  hintText: 'proxy.example.com:8080',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _httpProxy = value!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSNISection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Enable SNI'),
              value: _enableSni,
              onChanged: (value) {
                setState(() {
                  _enableSni = value;
                });
              },
              activeColor: Colors.deepPurple,
            ),
            if (_enableSni) ...[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'SNI Domain',
                  hintText: 'bug.example.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.public),
                ),
                onSaved: (value) => _sniDomain = value!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildV2RaySection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('V2Ray Settings'),
              value: _enableV2Ray,
              onChanged: (value) {
                setState(() {
                  _enableV2Ray = value;
                });
              },
              activeColor: Colors.deepPurple,
            ),
            if (_enableV2Ray) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _v2rayType,
                decoration: const InputDecoration(
                  labelText: 'V2Ray Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'vless', child: Text('VLESS')),
                  DropdownMenuItem(value: 'vmess', child: Text('VMESS')),
                  DropdownMenuItem(value: 'trojan', child: Text('TROJAN')),
                ],
                onChanged: (value) {
                  setState(() {
                    _v2rayType = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.dns),
                ),
                onSaved: (value) => _v2rayAddress = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Port',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.settings_ethernet),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _v2rayPort = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'UUID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.key),
                ),
                onSaved: (value) => _v2rayUuid = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Host',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.public),
                ),
                onSaved: (value) => _v2rayHost = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Path',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.route),
                ),
                onSaved: (value) => _v2rayPath = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'SNI',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.public),
                ),
                onSaved: (value) => _v2raySni = value!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _v2rayNetwork,
                decoration: const InputDecoration(
                  labelText: 'Network',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'tcp', child: Text('TCP')),
                  DropdownMenuItem(value: 'ws', child: Text('WebSocket')),
                  DropdownMenuItem(value: 'grpc', child: Text('gRPC')),
                ],
                onChanged: (value) {
                  setState(() {
                    _v2rayNetwork = value!;
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _v2raySecurity,
                decoration: const InputDecoration(
                  labelText: 'Security',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'none', child: Text('None')),
                  DropdownMenuItem(value: 'tls', child: Text('TLS')),
                ],
                onChanged: (value) {
                  setState(() {
                    _v2raySecurity = value!;
                  });
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSlowDNSSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('SlowDNS Settings'),
              value: _enableSlowDNS,
              onChanged: (value) {
                setState(() {
                  _enableSlowDNS = value;
                });
              },
              activeColor: Colors.deepPurple,
            ),
            if (_enableSlowDNS) ...[
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'NS Domain',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.dns),
                ),
                onSaved: (value) => _slowDnsNsDomain = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Public Key',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.key),
                ),
                onSaved: (value) => _slowDnsPublicKey = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'DNS IP',
                  hintText: '41.214.140.5',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.public),
                ),
                onSaved: (value) => _slowDnsDnsIp = value!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUDPSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('UDP Settings'),
              value: _enableUDP,
              onChanged: (value) {
                setState(() {
                  _enableUDP = value;
                });
              },
              activeColor: Colors.deepPurple,
            ),
            if (_enableUDP) ...[
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'UDP Server',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.dns),
                ),
                onSaved: (value) => _udpServer = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'UDP Port',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.settings_ethernet),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _udpPort = value!,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedToggle() {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          setState(() {
            _showAdvanced = !_showAdvanced;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Advanced Settings',
                style: TextStyle(fontSize: 16, fontWeight: FontW
