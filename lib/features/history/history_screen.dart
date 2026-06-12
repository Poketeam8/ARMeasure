import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/data/measurement_data.dart';
import '../../core/data/preferences_data.dart';
import '../../core/utils/measurement_utils.dart';
import 'detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Future<void> shareRecord(record) async {
    final text = """
📏 Medición ARMeasure

Distancia: ${MeasurementUtils.convert(record.value).toStringAsFixed(PreferencesData.decimals)} ${PreferencesData.unit}

😂 Chistes:
- ${record.jokes.join("\n- ")}

📱 Generado con ARMeasure
""";

    await Share.shareXFiles(
      [XFile(record.imagePath)],
      text: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final datos = MeasurementData.measurements;

    return Scaffold(
      appBar: AppBar(title: const Text("Historial")),
      body: datos.isEmpty
          ? const Center(child: Text("No hay mediciones"))
          : ListView.builder(
              itemCount: datos.length,
              itemBuilder: (context, index) {
                final item = datos[index];

                return Card(
                  child: ListTile(
                    // 📸 miniatura
                    leading: Image.file(
                      File(item.imagePath),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),

                    title: Text("Medición ${index + 1}"),

                    subtitle: Text(
                      "${MeasurementUtils.convert(item.value).toStringAsFixed(PreferencesData.decimals)} "
                      "${PreferencesData.unit}",
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(record: item),
                        ),
                      );
                    },

                    trailing: GestureDetector(
                      onTap: () => shareRecord(item),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/icons/compartir.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}