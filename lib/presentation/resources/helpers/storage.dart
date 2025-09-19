import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

// class SecureTokenStorage {
//   final _storage = const FlutterSecureStorage();
//   static const _tokenKey = 'user_token';
//
//   // In-memory cache of the token
//   static String? _cachedToken;
// SecureTokenStorage() {
//     initializeCache(); // Ensure cache is initialized on instance creation
//   }
//   bool isGuest() {
//     return _cachedToken == null || _cachedToken!.isEmpty;
//   }
//
//   Future<void> saveToken(String? token) async {
//     try {
//       _cachedToken = token;
//
//       if (token == null || token.isEmpty) {
//         await deleteToken();
//         return;
//       }
//       await _storage.write(
//         key: _tokenKey,
//         value: token,
//         iOptions: _getIOSOptions(),
//         aOptions: _getAndroidOptions(),
//       );
//     } catch (e) {
//       throw Exception('Failed to save token: $e');
//     }
//   }
//
//   Future<void> initializeCache() async {
//     try {
//       _cachedToken = await _storage.read(
//         key: _tokenKey,
//         iOptions: _getIOSOptions(),
//         aOptions: _getAndroidOptions(),
//       );
//       debugPrint("Token cache initialized: $_cachedToken");
//     } catch (e) {
//       _cachedToken = null;
//       debugPrint("Error initializing token cache: $e");
//     }
//     }
//
//   String? getToken() {
//     return _cachedToken;
//   }
//
//   Future<void> deleteToken() async {
//     try {
//       _cachedToken = null;
//       await _storage.delete(
//         key: _tokenKey,
//         iOptions: _getIOSOptions(),
//         aOptions: _getAndroidOptions(),
//       );
//     } catch (e) {
//       throw Exception('Failed to delete token: $e');
//     }
//   }
//
//   IOSOptions _getIOSOptions() => const IOSOptions(
//     accessibility: KeychainAccessibility.first_unlock,
//     // synchronizable: true,
//   );
//
//   AndroidOptions _getAndroidOptions() => const AndroidOptions(
//     encryptedSharedPreferences: true,
//     // resetOnError: false,
//   );
// }
//
// class SecureCourseStorage {
//   static const _storage = FlutterSecureStorage();
//
//   /// Saves the last lesson only if the user is logged in.
//   /// [tokenStorage] should be an instance of SecureTokenStorage.
//   static Future<void> saveLastLesson({
//     required String courseId,
//     required String lessonId,
//   }) async {
//     // Only save if the user is logged in
//     if (isGuest()) {
//       print("User is not logged in; skipping save for course $courseId");
//       return;
//     }
//
//     try {
//       await _storage.write(key: 'lastLesson_$courseId', value: lessonId);
//       print("Last lesson saved for course $courseId: $lessonId");
//     } catch (e) {
//       print("Error saving last lesson for course $courseId: $e");
//     }
//   }
//
//   /// Retrieves the last lesson only if the user is logged in.
//   /// [tokenStorage] should be an instance of SecureTokenStorage.
//   static Future<String?> getLastLesson({
//     required String courseId,
//   }) async {
//     // Only attempt to retrieve if the user is logged in
//     if (isGuest()) {
//       print("User is not logged in; skipping retrieval for course $courseId");
//       return null;
//     }
//
//     try {
//       final lessonId = await _storage.read(key: 'lastLesson_$courseId');
//       print("Last lesson retrieved for course $courseId: $lessonId");
//       return lessonId;
//     } catch (e) {
//       print("Error retrieving last lesson for course $courseId: $e");
//       return null;
//     }
//   }
// }


class TokenStorage {
  static final GetStorage _storage = GetStorage();
  static const String _tokenKey = 'token';

  static String? _cachedToken;

  TokenStorage() {
    initializeCache();
  }

  static bool isGuest() {
    return _cachedToken == null || _cachedToken!.isEmpty;
  }

  static void initializeCache() {
    try {
      _cachedToken = _storage.read(_tokenKey);
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

class CourseStorage {
  static final GetStorage _storage = GetStorage();

  static void saveLastLesson({
    required String courseId,
    required String lessonId,
  }) {
    if (TokenStorage.isGuest()) {
      print("User is not logged in; skipping save for course $courseId");
      return;
    }

    try {
      _storage.write('lastLesson_$courseId', lessonId);
      print("Last lesson saved for course $courseId: $lessonId");
    } catch (e) {
      print("Error saving last lesson for course $courseId: $e");
    }
  }

  static String? getLastLesson({
    required String courseId,
  }) {
    if (TokenStorage.isGuest()) {
      print("User is not logged in; skipping retrieval for course $courseId");
      return null;
    }

    try {
      final lessonId = _storage.read('lastLesson_$courseId');
      print("Last lesson retrieved for course $courseId: $lessonId");
      return lessonId;
    } catch (e) {
      print("Error retrieving last lesson for course $courseId: $e");
      return null;
    }
  }
}