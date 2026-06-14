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
        leading: IconButton(
          icon: Image.asset(
            'assets/images/icons/back.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.file(
              File(record.imagePath),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Distancia: "
              "${MeasurementUtils.convert(record.distance).toStringAsFixed(PreferencesData.decimals)} "
              "${PreferencesData.unit}",
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}