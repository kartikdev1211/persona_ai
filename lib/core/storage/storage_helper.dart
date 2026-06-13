import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  // Separate containers for System and User data
  static final GetStorage _systemBox = GetStorage('SystemStorage');
  static final GetStorage _userBox = GetStorage('UserStorage');
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> init() async {
    await GetStorage.init('SystemStorage');
    await GetStorage.init('UserStorage');
  }

  // --- System / Device Specific ---
  static bool get isOnboardingCompleted =>
      _systemBox.read('isOnboardingCompleted') ?? false;
  static set isOnboardingCompleted(bool value) =>
      _systemBox.write('isOnboardingCompleted', value);

  static bool get isDarkMode => _systemBox.read('isDarkMode') ?? true;
  static set isDarkMode(bool value) => _systemBox.write('isDarkMode', value);

  static bool get notificationsEnabled =>
      _systemBox.read('notificationsEnabled') ?? true;
  static set notificationsEnabled(bool value) =>
      _systemBox.write('notificationsEnabled', value);

  // --- User Specific ---
  static bool get isLoggedIn => _userBox.read('isLoggedIn') ?? false;
  static set isLoggedIn(bool value) => _userBox.write('isLoggedIn', value);

  static bool get isQuizCompleted => _userBox.read('isQuizCompleted') ?? false;
  static set isQuizCompleted(bool value) =>
      _userBox.write('isQuizCompleted', value);

  static bool get isPersonaSetupCompleted =>
      _userBox.read('isPersonaSetupCompleted') ?? false;
  static set isPersonaSetupCompleted(bool value) =>
      _userBox.write('isPersonaSetupCompleted', value);

  static String get userName => _userBox.read('userName') ?? '';
  static set userName(String value) => _userBox.write('userName', value);

  // Clear user data on logout but keep system settings
  static Future<void> clearUserSession() async {
    await _userBox.erase();
    await _secureStorage.deleteAll();
  }

  // --- Auth Tokens (Securely stored) ---
  static Future<String> getAuthToken() async {
    return await _secureStorage.read(key: 'authToken') ?? '';
  }

  static Future<void> saveAuthToken(String value) async {
    await _secureStorage.write(key: 'authToken', value: value);
  }

  static Future<String> getRefreshToken() async {
    return await _secureStorage.read(key: 'refreshToken') ?? '';
  }

  static Future<void> saveRefreshToken(String value) async {
    await _secureStorage.write(key: 'refreshToken', value: value);
  }
}
