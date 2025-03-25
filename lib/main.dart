import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/my-http-overrides.dart';
import 'package:riccos/route/screen_export.dart';
import 'package:riccos/services/auth_service.dart';
import 'package:riccos/route/route_constants.dart';
import 'package:riccos/route/router.dart' as router;
import 'package:riccos/services/categoria_service.dart';
import 'package:riccos/services/en_tienda_service.dart';
import 'package:riccos/services/pedido_service.dart';
import 'package:riccos/services/personal_empresa_service.dart';
import 'package:riccos/services/producto_service.dart';
import 'package:riccos/services/promocion_service.dart';
import 'package:riccos/services/websocket-service.dart';
import 'package:riccos/theme/app_theme.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthService()), // Inyecta el servicio
        Provider(
            create: (context) => EnTiendaService(context.read<AuthService>())),
        Provider(
            create: (context) => CategoriaService(context.read<AuthService>())),
        Provider(create: (context) => ProductoService()),
        Provider(create: (context) => PromocionService()),

        Provider(
            create: (context) => PedidoService(context.read<AuthService>())),
        Provider(
            create: (context) =>
                PersonalEmpresaService(context.read<AuthService>())),
        ChangeNotifierProvider(create: (_) => WebsocketService()),
        //Provider(create: (context) => ProductoService ()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Módulo Pedido',
      /*theme: ThemeData(
        primaryColor: Colors.amber, // Cambia este color según lo que desees
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Colors.amber, // Color primario
          secondary: Colors.deepOrange, // Color secundario
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber, // Color del AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white, // Color del texto seleccionado
          unselectedLabelColor: Colors.grey, // Color del texto no seleccionado
          indicatorColor: Colors.white, // Color del indicador
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),*/
      theme: AppTheme.lightTheme(context),
      // Dark theme is inclided in the Full template
      themeMode: ThemeMode.light,
      onGenerateRoute: router.generateRoute,
      initialRoute: logInScreenRoute,
    );
  }
}
