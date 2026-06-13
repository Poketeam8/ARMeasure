import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../measurement/measurement_screen.dart';
import '../history/history_screen.dart';
import '../preferences/preferences_screen.dart';
import '../survey/survey_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  final screens = const [
    HomeScreen(),
    MeasurementScreen(),
    HistoryScreen(),
    PreferencesScreen(),
    SurveyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/inicio.png',
              width: 24,
            ),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/medir.png',
              width: 24,
            ),
            label: "Medir",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/historial.png',
              width: 24,
            ),
            label: "Historial",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/settings.png',
              width: 24,
            ),
            label: "Preferencias",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/ayuda.png',
              width: 24,
            ),
            label: "Encuesta",
          ),
        ],
      ),
    );
  }
}