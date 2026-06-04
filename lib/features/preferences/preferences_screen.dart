import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/preferences_data.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  String unidad = "m";

  double decimales = 2;

  @override
  void initState() {
    super.initState();
    cargarPreferencias();
  }

  Future<void> cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      unidad = prefs.getString('unidad') ?? "m";

      decimales = prefs.getDouble('decimales') ?? 2;
    });

    PreferencesData.unit = unidad;
    PreferencesData.decimals = decimales.toInt();
  }

  Future<void> guardarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('unidad', unidad);

    await prefs.setDouble('decimales', decimales);

    PreferencesData.unit = unidad;

    PreferencesData.decimals = decimales.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferencias"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Unidad de medida",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile(
              title: const Text("Metros (m)"),
              value: "m",
              groupValue: unidad,
              onChanged: (value) async {
                setState(() {
                  unidad = value!;
                });

                await guardarPreferencias();
              },
            ),

            RadioListTile(
              title: const Text("Centímetros (cm)"),
              value: "cm",
              groupValue: unidad,
              onChanged: (value) async {
                setState(() {
                  unidad = value!;
                });

                await guardarPreferencias();
              },
            ),

            RadioListTile(
              title: const Text("Pulgadas (in)"),
              value: "in",
              groupValue: unidad,
              onChanged: (value) async {
                setState(() {
                  unidad = value!;
                });

                await guardarPreferencias();
              },
            ),

            RadioListTile(
              title: const Text("Pies (ft)"),
              value: "ft",
              groupValue: unidad,
              onChanged: (value) async {
                setState(() {
                  unidad = value!;
                });

                await guardarPreferencias();
              },
            ),

            const SizedBox(height: 30),

            Text(
              "Cantidad de decimales: ${decimales.toInt()}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Slider(
              value: decimales,
              min: 1,
              max: 5,
              divisions: 4,
              label: decimales.toInt().toString(),
              onChanged: (value) async {
                setState(() {
                  decimales = value;
                });

                await guardarPreferencias();
              },
            ),
          ],
        ),
      ),
    );
  }
}