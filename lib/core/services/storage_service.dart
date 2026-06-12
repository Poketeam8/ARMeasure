import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/measurement_record.dart';

class StorageService {
  static const key = 'measurements';

  static Future<void> saveMeasurements(
    List<MeasurementRecord> values,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final data = values.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }

  static Future<List<MeasurementRecord>> loadMeasurements() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key) ?? [];

    return data
        .map((e) => MeasurementRecord.fromJson(jsonDecode(e)))
        .toList();
  }
}