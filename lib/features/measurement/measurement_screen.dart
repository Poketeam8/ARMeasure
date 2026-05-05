import 'package:flutter/material.dart';
import 'dart:math';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  double? distancia;

  void medir() {
    setState(() {
      distancia = Random().nextDouble() * 5; // simula metros
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Medir")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Simulación de medición AR"),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: medir, child: const Text("Medir")),
            const SizedBox(height: 20),
            if (distancia != null)
              Text("Distancia: ${distancia!.toStringAsFixed(2)} m"),
          ],
        ),
      ),
    );
  }
}
