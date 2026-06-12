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
      appBar: AppBar(title: const Text("Detalle de medición")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // 📸 IMAGEN GRANDE
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(record.imagePath),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📏 MEDICIÓN
            Text(
              "Distancia: ${MeasurementUtils.convert(record.value).toStringAsFixed(PreferencesData.decimals)} ${PreferencesData.unit}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // 😂 CHISTES
            const Text(
              "Chistes del proceso",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: record.jokes
                    .map(
                      (joke) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          "😂 $joke",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}