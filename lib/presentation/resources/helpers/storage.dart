import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static final GetStorage _storage = GetStorage();
  static const String _tokenKey = 'token';

  static String? _cachedToken;

 //TokenStorage() {
 //  initializeCache();
 //}

  static bool isGuest() {
    return _cachedToken == null || _cachedToken!.isEmpty;
  }

  static Future<void> initializeCache() async {
    try {
      _cachedToken = await _storage.read(_tokenKey);
      debugPrint("Token cache initialized: $_cachedToken");
    } catch (e) {
      _cachedToken = null;
      debugPrint("Error initializing token cache: $e");
    }
  }

  Future<void> saveToken(String? token) async {
    _cachedToken = token;
    if (token == null || token.isEmpty) {
      deleteToken();
      return;
    }
    await _storage.write(_tokenKey, token);
  }

   String? getToken() {
    return _cachedToken;
  }

   void deleteToken() {
    _cachedToken = null;
    _storage.remove(_tokenKey);
  }
}