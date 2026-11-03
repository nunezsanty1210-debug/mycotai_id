import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student.dart';

class StorageService {
  static const _key = 'students';

  static Future<List<Student>> loadStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => Student.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> saveStudents(List<Student> students) async {
    final prefs = await SharedPreferences.getInstance();
    final data = students.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, data);
  }
}