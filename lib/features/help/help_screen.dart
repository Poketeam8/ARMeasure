import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ayuda")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text("1. Ir a Medir\n2. Presionar botón\n3. Ver resultado"),
      ),
    );
  }
}
