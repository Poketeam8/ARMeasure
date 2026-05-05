import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Mide objetos usando realidad aumentada.\n\nVe a la pestaña 'Medir' para comenzar.",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
