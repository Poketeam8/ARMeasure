import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../core/data/preferences_data.dart';
import '../../core/utils/measurement_utils.dart';
import '../../core/data/measurement_data.dart';
import '../../core/services/storage_service.dart';
import '../../main.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({super.key});

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  CameraController? controller;

  bool isLoading = true;

  String estado = "Inicializando cámara...";

  double? distancia;

  @override
  void initState() {
    super.initState();
    iniciarCamara();
  }

  Future<void> iniciarCamara() async {
    try {
      controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
      );

      await controller!.initialize();

      setState(() {
        isLoading = false;
        estado = "Cámara lista";
      });
    } catch (e) {
      setState(() {
        estado = "Error al iniciar cámara";
      });
    }
  }

  Future<void> medir() async {
    final nuevaDistancia = Random().nextDouble() * 5;

    setState(() {
      distancia = nuevaDistancia;

      MeasurementData.measurements.add(nuevaDistancia);
    });

    await StorageService.saveMeasurements(
      MeasurementData.measurements,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Medir")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              estado,
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            if (isLoading)
              const CircularProgressIndicator()
            else if (controller != null &&
                controller!.value.isInitialized)
              AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: CameraPreview(controller!),
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
                    "Distancia: "
                    "${MeasurementUtils.convert(distancia!)
                        .toStringAsFixed(PreferencesData.decimals)} "
                    "${PreferencesData.unit}",

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