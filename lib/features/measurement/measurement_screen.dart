import 'dart:math';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/data/measurement_record.dart';
import '../../core/data/preferences_data.dart';
import '../../core/utils/measurement_utils.dart';
import '../../core/data/measurement_data.dart';
import '../../core/services/storage_service.dart';
import '../../main.dart';
import 'loading_jokes_screen.dart';

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
      estado = "Inicializando cámara...";
    });

    try {
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
        estado = "Error de cámara";
      });
    }
  }

  Future<void> medir() async {
    if (controller == null || !controller!.value.isInitialized) return;

    final photo = await controller!.takePicture();

    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => LoadingJokesScreen(
          onFinish: (jokes) async {
            final nuevaDistancia = Random().nextDouble() * 5;

            final dir = await getApplicationDocumentsDirectory();
            final fileName = DateTime.now().millisecondsSinceEpoch.toString();

            final savedImage =
                await File(photo.path).copy('${dir.path}/$fileName.jpg');

            final record = MeasurementRecord(
              value: nuevaDistancia,
              imagePath: savedImage.path,
              jokes: jokes,
            );

            MeasurementData.measurements.add(record);

            await StorageService.saveMeasurements(
              MeasurementData.measurements,
            );

            setState(() {
              distancia = nuevaDistancia;
            });
          },
        ),
      ),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(estado),

            const SizedBox(height: 20),

            if (isLoading)
              const CircularProgressIndicator()
            else if (controller != null &&
                controller!.value.isInitialized)
              AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: CameraPreview(controller!),
              ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: medir,
              child: const Text("Realizar medición"),
            ),

            const SizedBox(height: 20),

            if (distancia != null)
              Text(
                "${MeasurementUtils.convert(distancia!).toStringAsFixed(PreferencesData.decimals)} "
                "${PreferencesData.unit}",
              ),
          ],
        ),
      ),
    );
  }
}