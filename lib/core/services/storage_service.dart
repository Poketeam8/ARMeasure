import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/measurement_record.dart';

class StorageService {
  static const String key = 'measurement_records';

  static Future<void> saveRecords(
    List<MeasurementRecord> records,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final data = records
        .map((record) => jsonEncode(record.toJson()))
        .toList();

    await prefs.setStringList(key, data);
  }

  static Future<List<MeasurementRecord>> loadRecords() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key) ?? [];

    return data
        .map(
          (e) => MeasurementRecord.fromJson(
            jsonDecode(e),
          ),
        )
        .toList();
  }
}