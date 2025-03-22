import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/route/screen_export.dart';
import 'package:riccos/screens/discover/views/discover_screen.dart';
import 'package:riccos/section-connection.dart';

class EntryPoint extends StatefulWidget {
  final int initialIndex; // Nuevo parámetro para indicar la pantalla de inicio
  const EntryPoint(
      {super.key, this.initialIndex = 0}); // Default: DiscoverScreen

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  late int _currentIndex; // Inicialización tardía

  final List<Widget> _pages = const [
    DiscoverScreen(),
    MesasScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Usa el índice recibido
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Módulo de Pedidos'),
          backgroundColor: secondaryColor,
        ),
        body: Column(
          children: [
            SectionConnection(), // Agregamos la sección de conexión
            Expanded(
              // Permite que el contenido principal ocupe el espacio restante
              child: PageTransitionSwitcher(
                duration: defaultDuration,
                transitionBuilder: (child, animation, secondAnimation) {
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondAnimation,
                    child: child,
                  );
                },
                child: _pages[_currentIndex],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: primaryColor,
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          selectedItemColor: secondaryColor,
          unselectedItemColor: secondaryColorS,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              activeIcon: Icon(Icons.receipt_long, color: secondaryColor),
              label: "Mis Pedidos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_bar_outlined),
              activeIcon: Icon(Icons.table_bar_outlined, color: secondaryColor),
              label: "Mesas",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person, color: secondaryColor),
              label: "Mi Perfil",
            ),
          ],
        ),
      ),
    );
  }
}
