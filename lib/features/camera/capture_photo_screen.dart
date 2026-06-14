import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CapturePhotoScreen extends StatefulWidget {
  final CameraDescription camera;

  const CapturePhotoScreen({
    super.key,
    required this.camera,
  });

  @override
  State<CapturePhotoScreen> createState() =>
      _CapturePhotoScreenState();
}

class _CapturePhotoScreenState
    extends State<CapturePhotoScreen> {
  CameraController? controller;
  bool ready = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller!.initialize();

    setState(() {
      ready = true;
    });
  }

  Future<void> takePhoto() async {
    if (controller == null) return;

    final file = await controller!.takePicture();

    Navigator.pop(context, file.path);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!ready) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tomar Foto"),

        // BACK PERSONALIZADO
        leading: IconButton(
          icon: Image.asset(
            'assets/images/icons/back.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          CameraPreview(controller!),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: takePhoto,
                child: Image.asset(
                  'assets/images/icons/camera.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}