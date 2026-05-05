import 'package:flutter/material.dart';
import 'detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<double> datos = const [1.2, 2.5, 3.8];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial")),
      body: ListView.builder(
        itemCount: datos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Medición ${index + 1}"),
            subtitle: Text("${datos[index]} m"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(valor: datos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
