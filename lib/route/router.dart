import 'package:flutter/material.dart';
import 'package:riccos/entry_point.dart';
import 'package:riccos/menu_pedidooo.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:riccos/models/usuarios_sistema_response_model.dart';
import 'package:riccos/screens/historial-mesa/historia_pedido_mesa_screen.dart';
import 'package:riccos/screens/pedidos-personal/pedidos_dia_screen.dart';
import 'package:riccos/screens/profile/views/edit_profile_screen.dart';
import 'package:riccos/screens/resumen/resumen_pedido_screen.dart';

import 'screen_export.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case pedidosDelPersonalScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PedidosDiaScreen(),
      );

    case passwordRecoveryScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PasswordRecoveryScreen(),
      );
    case logInScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case passwordRecoveryScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PasswordRecoveryScreen(),
      );

    case categoriaScreenRoute:
      return MaterialPageRoute(builder: (context) {
        final pedidoMesa = settings.arguments as PedidoMesaModel;
        return CategoriaScreen(pedidoMesa: pedidoMesa);
      });

    case productoScreenRoute:
      return MaterialPageRoute(builder: (context) {
        final args = settings.arguments as ProductoScreenArguments;
        return ProductoScreen(
            pedidoMesa: args.pedidoMesa,
            nombreCategoria: args.nombreCategoria,
            idCategoria: args.idCategoria);
      });

    case searchScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      );
    case MesasScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const MesasScreen(),
      );
    case entryPointScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EntryPoint(),
      );

    case menuPedidoooScreenRoute:
      return MaterialPageRoute(builder: (context) {
        final pedidoMesa = settings.arguments as PedidoMesaModel;
        return MenuPedidooo(pedidoMesa: pedidoMesa);
      });

    case editProfileScreenRoute:
      return MaterialPageRoute(builder: (context) {
        final args = settings.arguments as UsuariosSistemaResponseModel;
        return EditProfileScreen(userData: args);
      });

    //return MaterialPageRoute(builder: (context) => const MenuPedidooo());

    case historialPedidoMesaScreenRoute:
      return MaterialPageRoute(builder: (context) {
        final pedidoMesa = settings.arguments as PedidoMesaModel;
        return HistorialPedidoMesaScreen(pedidoMesa: pedidoMesa);
      });
    // return MaterialPageRoute(builder: (context) => HistorialPedidoMesaScreen());

    case resumenPedidoScreenRoute:
      return MaterialPageRoute(builder: (context) {
        final pedidoMesa = settings.arguments as PedidoMesaModel;
        return ResumenPedidoScreen(pedidoMesa: pedidoMesa);
      });
    //  return MaterialPageRoute(builder: (context) => const ResumenPedidoScreen());

    default:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
  }
}
