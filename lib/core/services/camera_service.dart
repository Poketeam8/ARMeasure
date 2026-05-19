import 'package:camera/camera.dart';

class CameraService {
  late CameraController controller;

  Future<void> initialize(CameraDescription camera) async {
    controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    await controller.initialize();
  }

  void dispose() {
    controller.dispose();
  }
}