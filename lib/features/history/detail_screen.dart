import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final double valor;

  const DetailScreen({super.key, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle")),
      body: Center(
        child: Text(
          "Distancia: $valor m",
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
