import 'package:flutter/material.dart';
import 'detail_screen.dart';
import '../../core/data/measurement_data.dart';
import '../../core/data/preferences_data.dart';
import '../../core/utils/measurement_utils.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final datos = MeasurementData.measurements;

    return Scaffold(
      appBar: AppBar(title: const Text("Historial")),
      body: datos.isEmpty
          ? const Center(child: Text("No hay mediciones aún"))
          : ListView.builder(
              itemCount: datos.length,
              itemBuilder: (context, index) {
                final valor = datos[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/icons/medir.png',
                      width: 30,
                    ),
                    title: Text("Medición ${index + 1}"),
                    subtitle: Text(
                      "${MeasurementUtils.convert(valor)
                          .toStringAsFixed(PreferencesData.decimals)} "
                      "${PreferencesData.unit}",
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(valor: valor),
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
