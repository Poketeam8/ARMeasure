import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vm;
import 'package:arcore_flutter_plus/arcore_flutter_plus.dart';

import '../../main.dart';
import '../camera/capture_photo_screen.dart';
import '../../core/data/measurement_record.dart';
import '../../core/data/preferences_data.dart';
import '../../core/utils/measurement_utils.dart';
import '../../core/data/measurement_data.dart';
import '../../core/services/storage_service.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  ArCoreController? arCoreController;

  String estado = "Mire a su alrededor hasta que aparezcan puntos blancos";

  vm.Vector3? punto1;
  vm.Vector3? punto2;

  ArCoreNode? nodo1;
  ArCoreNode? nodo2;

  bool calibrado = false;

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController!.onPlaneTap = _onPlaneTap;
  }

  ArCoreNode _crearPuntoRojo(vm.Vector3 position) {
    final material = ArCoreMaterial(color: Colors.red);

    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.03,
    );

    return ArCoreNode(
      shape: sphere,
      position: position,
    );
  }

  void _onPlaneTap(List<ArCoreHitTestResult> results) {
    if (results.isEmpty) return;
    if (arCoreController == null) return;

    final hit = results.first;
    final position = hit.pose.translation;

    setState(() {
      if (!calibrado) {
        calibrado = true;
      }

      if (punto1 == null) {
        punto1 = position;

        nodo1 = _crearPuntoRojo(position);
        arCoreController?.addArCoreNode(nodo1!);

        estado = "Primer punto colocado. Toca el segundo punto";
      } else if (punto2 == null) {
        punto2 = position;

        nodo2 = _crearPuntoRojo(position);
        arCoreController?.addArCoreNode(nodo2!);

        estado = "Segundo punto colocado";
      }
    });
  }

  Future<void> medir() async {
    if (punto1 == null || punto2 == null) {
      setState(() {
        estado = "Debes seleccionar 2 puntos primero";
      });
      return;
    }

    final dx = punto2!.x - punto1!.x;
    final dy = punto2!.y - punto1!.y;
    final dz = punto2!.z - punto1!.z;

    final distancia = sqrt(dx * dx + dy * dy + dz * dz);

    setState(() {
      estado = "Medición completada";
    });

    if (cameras.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("Error"),
          content: Text("No hay cámaras disponibles"),
        ),
      );
      return;
    }

    final imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CapturePhotoScreen(
          camera: cameras.first,
        ),
      ),
    );

    if (imagePath != null) {
      final nuevos = List<MeasurementRecord>.from(
        MeasurementData.records.value,
      );

      nuevos.add(
        MeasurementRecord(
          distance: distancia,
          imagePath: imagePath,
        ),
      );

      MeasurementData.records.value = nuevos;

      await StorageService.saveRecords(
        MeasurementData.records.value,
      );
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Resultado"),
        content: Text(
          "Distancia: "
          "${MeasurementUtils.convert(distancia).toStringAsFixed(PreferencesData.decimals)} "
          "${PreferencesData.unit}",
        ),
      ),
    );
  }

  void reset() {
    setState(() {
      punto1 = null;
      punto2 = null;
      estado = "Toca 2 nuevos puntos";
    });

    if (nodo1 != null) {
      arCoreController?.removeNode(nodeName: nodo1!.name);
      nodo1 = null;
    }

    if (nodo2 != null) {
      arCoreController?.removeNode(nodeName: nodo2!.name);
      nodo2 = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medición AR real"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (!calibrado) ...[
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12),
                ],
                Text(
                  estado,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                if (calibrado)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: medir,
                        child: const Text("Medir"),
                      ),
                      ElevatedButton(
                        onPressed: reset,
                        child: const Text("Reset"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}