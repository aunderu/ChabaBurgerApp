import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyUserUid = 'uid';
  static const _keyUserName = 'userName';
  static const _keyUserEmail = 'userEmail';
  static const _keyUserAvatar = 'avatar';
  static const _keyUserRole = 'role';
  static const _keyUserGender = 'gender';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUid(String uid) async =>
      await _preferences?.setString(_keyUserUid, uid);
  static Future setName(String userName) async =>
      await _preferences?.setString(_keyUserName, userName);
  static Future setEmail(String userEmail) async =>
      await _preferences?.setString(_keyUserEmail, userEmail);
  static Future setAvatar(String userAvatar) async =>
      await _preferences?.setString(_keyUserAvatar, userAvatar);
  static Future setRole(String userRole) async =>
      await _preferences?.setString(_keyUserRole, userRole);
  static Future setGender(String userGender) async =>
      await _preferences?.setString(_keyUserGender, userGender);

  static String? getToken() => _preferences!.getString(_keyUserUid);
  static String? getName() => _preferences!.getString(_keyUserName);
  static String? getEmail() => _preferences!.getString(_keyUserEmail);
  static String? getAvatar() => _preferences!.getString(_keyUserAvatar);
  static String? getRole() => _preferences!.getString(_keyUserRole);
  static String? getGender() => _preferences!.getString(_keyUserGender);
}
