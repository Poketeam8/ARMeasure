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
  bool hasPermission = true;
  String estado = "Inicializando cámara...";
  double? distancia;

  @override
  void initState() {
    super.initState();
    iniciarCamara();
  }

  Future<void> iniciarCamara() async {
    setState(() {
      isLoading = true;
      hasPermission = true;
      estado = "Inicializando cámara...";
    });

    try {
      if (cameras.isEmpty) {
        throw CameraException("NoCameras", "No se encontraron cámaras en el dispositivo");
      }

      controller = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller!.initialize();

      setState(() {
        isLoading = false;
        hasPermission = true;
        estado = "Cámara lista";
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasPermission = false; 
        estado = "Error de acceso";
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
        child: Center( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                estado,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              if (isLoading)
                const CircularProgressIndicator()
              else if (!hasPermission)

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   
                    Image.asset(
                      'assets/images/icons/warning.png', width: 80,height: 80,fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "(No se tiene acceso a la cámara)",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: iniciarCamara,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Pedir acceso de nuevo"),
                    ),
                  ],
                )
              else if (controller != null && controller!.value.isInitialized)
                AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CameraPreview(controller!),
                ),

              if (!isLoading && hasPermission) ...[
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: medir,
                  child: const Text("Realizar medición"),
                ),
              ],

              const SizedBox(height: 30),

              if (distancia != null && hasPermission)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Distancia: "
                      "${MeasurementUtils.convert(distancia!).toStringAsFixed(PreferencesData.decimals)} "
                      "${PreferencesData.unit}",
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}