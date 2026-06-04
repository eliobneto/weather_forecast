import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ISecureLocalStorage {
  Future<dynamic> read(String key);

  Future<void> write(String key, dynamic data);

  Future<void> delete(String key);
}

class SecureLocalStorage extends ISecureLocalStorage {
  @override
  Future<dynamic> read(String key) async {
    try {
      final instance = const FlutterSecureStorage();

      final data = await instance.read(key: key);

      if (data == null) return null;

      return json.decode(data);
    } catch (error) {
      debugPrint(
        'Error reading from secure local storage: ${error.toString()}',
      );
    }
  }

  @override
  Future<void> write(String key, dynamic data) async {
    try {
      final instance = const FlutterSecureStorage();

      final encoded = json.encode(data);

      await instance.write(key: key, value: encoded);
    } catch (error) {
      debugPrint('Error writing to secure local storage: ${error.toString()}');
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      final instance = const FlutterSecureStorage();

      await instance.delete(key: key);
    } catch (error) {
      debugPrint('Error deleting to secure local storage: ${error.toString()}');
    }
  }
}
