import 'package:flutter/material.dart';
import 'measurement_record.dart';

class MeasurementData {
  static ValueNotifier<List<MeasurementRecord>> records =
      ValueNotifier([]);
}