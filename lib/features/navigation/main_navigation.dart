import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../measurement/measurement_screen.dart';
import '../history/history_screen.dart';
import '../about/about_screen.dart';
import '../help/help_screen.dart';

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
    AboutScreen(),
    HelpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icons/inicio.png', width: 24),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icons/medir.png', width: 24),
            label: "Medir",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icons/historial.png', width: 24),
            label: "Historial",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icons/about.png', width: 24),
            label: "About",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icons/ayuda.png', width: 24),
            label: "Ayuda",
          ),
        ],
      ),
    );
  }
}
