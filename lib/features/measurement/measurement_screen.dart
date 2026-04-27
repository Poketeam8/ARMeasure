import 'package:flutter/material.dart';

class MeasurementScreen extends StatelessWidget {
  const MeasurementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Medición")),
      body: const Center(child: Text("Pantalla de medición (AR aquí)")),
    );
  }
}
