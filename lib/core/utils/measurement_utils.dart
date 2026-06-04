import '../data/preferences_data.dart';

class MeasurementUtils {
  static double convert(double valueInMeters) {
    switch (PreferencesData.unit) {
      case 'cm':
        return valueInMeters * 100;

      case 'in':
        return valueInMeters * 39.3701;

      case 'ft':
        return valueInMeters * 3.28084;

      default:
        return valueInMeters;
    }
  }
}