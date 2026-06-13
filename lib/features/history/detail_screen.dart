import 'dart:io';
import 'package:flutter/material.dart';

import '../../core/data/measurement_record.dart';
import '../../core/data/preferences_data.dart';
import '../../core/utils/measurement_utils.dart';

class DetailScreen extends StatelessWidget {
  final MeasurementRecord record;

  const DetailScreen({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              File(record.imagePath),
              width: 250,
            ),
            const SizedBox(height: 20),
            Text(
              "Distancia: "
              "${MeasurementUtils.convert(record.distance).toStringAsFixed(PreferencesData.decimals)} "
              "${PreferencesData.unit}",
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}