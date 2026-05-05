import 'package:flutter/material.dart';
import 'dart:math';
import '../../core/data/measurement_data.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  double? distancia;

  void medir() {
    final nuevaDistancia = Random().nextDouble() * 5;

    setState(() {
      distancia = nuevaDistancia;
      MeasurementData.measurements.add(nuevaDistancia);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Medir")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/icons/medir.png', width: 80),
            const SizedBox(height: 20),

            const Text(
              "Simulación de medición AR",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: medir,
              child: const Text("Realizar medición"),
            ),

            const SizedBox(height: 30),

            if (distancia != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Distancia: ${distancia!.toStringAsFixed(2)} m",
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
