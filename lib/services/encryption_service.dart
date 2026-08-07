// lib/services/encryption_service.dart

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();

  static const String _key = 'ABDELLALI_PRO_2026_SECURE_KEY_32_BYTES!!';

  // Simple XOR encryption (since pointycastle has issues)
  String _xorEncrypt(String plainText) {
    List<int> plainBytes = utf8.encode(plainText);
    List<int> keyBytes = utf8.encode(_key);
    List<int> encrypted = [];

    for (int i = 0; i < plainBytes.length; i++) {
      encrypted.add(plainBytes[i] ^ keyBytes[i % keyBytes.length]);
    }

    return base64.encode(encrypted);
  }

  String _xorDecrypt(String cipherText) {
    List<int> encrypted = base64.decode(cipherText);
    List<int> keyBytes = utf8.encode(_key);
    List<int> decrypted = [];

    for (int i = 0; i < encrypted.length; i++) {
      decrypted.add(encrypted[i] ^ keyBytes[i % keyBytes.length]);
    }

    return utf8.decode(decrypted);
  }

  // Encrypt config
  String encryptConfig(Map<String, dynamic> configData) {
    final jsonString = json.encode(configData);
    return _xorEncrypt(jsonString);
  }

  // Decrypt config
  Map<String, dynamic> decryptConfig(String encryptedData) {
    try {
      final jsonString = _xorDecrypt(encryptedData);
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  // Generate signature
  String generateSignature(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Verify signature
  bool verifySignature(String data, String signature) {
    try {
      final computed = generateSignature(data);
      return computed == signature;
    } catch (e) {
      return false;
    }
  }

  // Check if encrypted
  bool isEncrypted(String data) {
    try {
      base64.decode(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
