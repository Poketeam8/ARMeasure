import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'detail_screen.dart';
import '../../core/data/measurement_data.dart';
import '../../core/data/measurement_record.dart';
import '../../core/data/preferences_data.dart';
import '../../core/utils/measurement_utils.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<void> compartirMedicion(
    MeasurementRecord record,
  ) async {
    final texto =
        "Medición AR:\n"
        "${MeasurementUtils.convert(record.distance).toStringAsFixed(PreferencesData.decimals)} "
        "${PreferencesData.unit}";

    await Share.shareXFiles(
      [XFile(record.imagePath)],
      text: texto,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial"),
      ),
      body: ValueListenableBuilder<List<MeasurementRecord>>(
        valueListenable: MeasurementData.records,
        builder: (context, datos, _) {
          if (datos.isEmpty) {
            return const Center(
              child: Text("No hay mediciones aún"),
            );
          }

          return ListView.builder(
            itemCount: datos.length,
            itemBuilder: (context, index) {
              final record = datos[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: Image.file(
                    File(record.imagePath),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text("Medición ${index + 1}"),
                  subtitle: Text(
                    "${MeasurementUtils.convert(record.distance).toStringAsFixed(PreferencesData.decimals)} "
                    "${PreferencesData.unit}",
                  ),
                  trailing: IconButton(
                    icon: Image.asset(
                      'assets/images/icons/share.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    onPressed: () => compartirMedicion(record),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                          record: record,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}