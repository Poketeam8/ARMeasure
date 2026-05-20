import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const key = 'measurements';

  static Future<void> saveMeasurements(
    List<double> values,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final data = values.map((e) => e.toString()).toList();

    await prefs.setStringList(key, data);
  }

  static Future<List<double>> loadMeasurements() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key) ?? [];

    return data.map((e) => double.parse(e)).toList();
  }
}