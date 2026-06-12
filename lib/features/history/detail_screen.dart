import 'package:flutter/material.dart';
import '../../core/data/preferences_data.dart';
import '../../core/utils/measurement_utils.dart';

class DetailScreen extends StatelessWidget {
  final double valor;

  const DetailScreen({super.key, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle")),
      body: Center(
        child: Text(
          "${MeasurementUtils.convert(valor).toStringAsFixed(PreferencesData.decimals)} "
          "${PreferencesData.unit}",
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}