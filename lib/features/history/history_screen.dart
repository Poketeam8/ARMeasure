import 'dart:io';
import 'package:flutter/material.dart';

import '../../core/data/measurement_data.dart';
import '../../core/data/preferences_data.dart';
import '../../core/utils/measurement_utils.dart';
import 'detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
                          builder: (_) => DetailScreen(valor: item.value),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}