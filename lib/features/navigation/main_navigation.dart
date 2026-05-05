import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../measurement/measurement_screen.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';
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
    ProfileScreen(),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.straighten), label: "Medir"),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Historial",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: "Ayuda"),
        ],
      ),
    );
  }
}
