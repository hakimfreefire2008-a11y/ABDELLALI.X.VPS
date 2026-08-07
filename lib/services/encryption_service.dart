// lib/services/encryption_service.dart

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:flutter/services.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();

  static const String _key = 'ABDELLALI_PRO_2026_SECURE_KEY_32_BYTES!!'; // 32 bytes

  Uint8List _getKey() {
    return Uint8List.fromList(utf8.encode(_key));
  }

  Uint8List _getIV() {
    final random = Random.secure();
    final iv = Uint8List(16);
    for (int i = 0; i < 16; i++) {
      iv[i] = random.nextInt(256);
    }
    return iv;
  }

  // Encrypt data
  String encrypt(String plainText) {
    try {
      final key = _getKey();
      final iv = _getIV();
      
      final cipher = CBCBlockCipher(AESEngine())
        ..init(true, ParametersWithIV(KeyParameter(key), iv));
      
      final plainBytes = utf8.encode(plainText);
      final paddedBytes = _pad(plainBytes, cipher.blockSize);
      final encrypted = Uint8List(paddedBytes.length);
      
      int offset = 0;
      while (offset < paddedBytes.length) {
        offset += cipher.processBlock(paddedBytes, offset, encrypted, offset);
      }
      
      // Combine IV + encrypted data
      final result = Uint8List(iv.length + encrypted.length)
        ..setAll(0, iv)
        ..setAll(iv.length, encrypted);
      
      return base64.encode(result);
    } catch (e) {
      return plainText;
    }
  }

  // Decrypt data
  String decrypt(String cipherText) {
    try {
      final combined = base64.decode(cipherText);
      
      // Extract IV
      final iv = combined.sublist(0, 16);
      final encrypted = combined.sublist(16);
      
      final key = _getKey();
      final cipher = CBCBlockCipher(AESEngine())
        ..init(false, ParametersWithIV(KeyParameter(key), iv));
      
      final decrypted = Uint8List(encrypted.length);
      int offset = 0;
      while (offset < encrypted.length) {
        offset += cipher.processBlock(encrypted, offset, decrypted, offset);
      }
      
      final unpadded = _unpad(decrypted);
      return utf8.decode(unpadded);
    } catch (e) {
      return cipherText;
    }
  }

  // Pad data to block size
  List<int> _pad(List<int> data, int blockSize) {
    final padLength = blockSize - (data.length % blockSize);
    final padded = List<int>.from(data);
    padded.addAll(List.filled(padLength, padLength));
    return padded;
  }

  // Unpad data
  List<int> _unpad(List<int> data) {
    if (data.isEmpty) return data;
    final padLength = data.last;
    if (padLength < 1 || padLength > data.length) return data;
    return data.sublist(0, data.length - padLength);
  }

  // Encrypt config to .abde format
  String encryptConfig(Map<String, dynamic> configData) {
    final jsonString = json.encode(configData);
    return encrypt(jsonString);
  }

  // Decrypt config from .abde format
  Map<String, dynamic> decryptConfig(String encryptedData) {
    try {
      final jsonString = decrypt(encryptedData);
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  // Generate file signature
  String generateSignature(String data) {
    // Simple signature using hash
    final bytes = utf8.encode(data);
    final digest = SHA256Digest();
    final result = Uint8List(digest.digestSize);
    digest.processBytes(bytes, 0, bytes.length);
    digest.doFinal(result, 0);
    return base64.encode(result);
  }

  // Verify file signature
  bool verifySignature(String data, String signature) {
    try {
      final computed = generateSignature(data);
      return computed == signature;
    } catch (e) {
      return false;
    }
  }

  // Check if data is encrypted (detects AES format)
  bool isEncrypted(String data) {
    try {
      final decoded = base64.decode(data);
      return decoded.length > 16; // IV(16) + at least 1 byte
    } catch (e) {
      return false;
    }
  }
}
