// ignore_for_file: non_constant_identifier_names

import 'package:kale/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  int get id => _sharedPrefs.getInt(Keys.key_id) ?? -1;
  set id(int value) {
    _sharedPrefs.setInt(Keys.key_id, value);
  }
}
