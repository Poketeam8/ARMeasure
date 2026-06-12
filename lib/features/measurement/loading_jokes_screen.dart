import 'dart:math';
import 'package:flutter/material.dart';

class LoadingJokesScreen extends StatefulWidget {
  final Future<void> Function(List<String> jokes) onFinish;

  const LoadingJokesScreen({
    super.key,
    required this.onFinish,
  });

  @override
  State<LoadingJokesScreen> createState() => _LoadingJokesScreenState();
}

class _LoadingJokesScreenState extends State<LoadingJokesScreen> {
  final List<String> allJokes = [
    "Esperando que Miami confirme la medición...",
    "Contando los átomos de la imagen...",
    "Calibrando las dimensiones...",
    "Preguntándole a Schrödinger si la imagen está viva o muerta...",
    "Negociando con Cthulhu para que mida la imagen...",
    "Consultando con NASA...",
    "Esperando que el Vaticano santifique la medición...",
    "Consolando a la imagen...",
  ];

  late List<String> selectedJokes;
  int index = 0;

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() {
    final random = Random();

    selectedJokes = List.from(allJokes)..shuffle(random);
    selectedJokes = selectedJokes.take(3).toList();

    run();
  }

  Future<void> run() async {
    for (int i = 0; i < selectedJokes.length; i++) {
      if (!mounted) return;

      setState(() => index = i);
      await Future.delayed(const Duration(seconds: 2));
    }

    await widget.onFinish(selectedJokes);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          selectedJokes[index],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}