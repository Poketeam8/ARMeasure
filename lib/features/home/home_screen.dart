import 'package:flutter/material.dart';
import '../measurement/measurement_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AR Measure")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.straighten, size: 100),
            const SizedBox(height: 20),
            const Text(
              "Mide objetos con Realidad Aumentada",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "Apunta tu cámara y mide distancias sin necesidad de una regla física.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MeasurementScreen()),
                );
              },
              child: const Text("Comenzar"),
            ),
          ],
        ),
      ),
    );
  }
}
