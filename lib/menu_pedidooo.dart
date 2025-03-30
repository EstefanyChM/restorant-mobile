import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/entry_point.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:riccos/providers/pedido_provider.dart';
import 'package:riccos/route/screen_export.dart';
import 'package:riccos/screens/historial-mesa/historia_pedido_mesa_screen.dart';
import 'package:riccos/screens/resumen/resumen_pedido_screen.dart';

import 'package:riccos/section-connection.dart';

class MenuPedidooo extends StatelessWidget {
  const MenuPedidooo({Key? key, required this.pedidoMesa}) : super(key: key);
  final PedidoMesaModel pedidoMesa;

  @override
  Widget build(BuildContext context) {
    bool isHistorialEnabled = pedidoMesa.idPedido != null;

    final List<Tab> tabs = [
      const Tab(
        icon: Icon(
          Icons.home_rounded,
          size: 40,
        ),
        child: Text(
          "Seleccionar",
          style: TextStyle(fontSize: 20),
        ),
      ),
      const Tab(
        icon: Icon(
          Icons.shopping_bag_rounded,
          size: 40,
        ),
        child: Text(
          "Resumen",
          style: TextStyle(fontSize: 20),
        ),
      ),
      if (isHistorialEnabled)
        const Tab(
          icon: Icon(
            Icons.person,
            size: 40,
          ),
          child: Text(
            "Historial",
            style: TextStyle(fontSize: 20),
          ),
        ),
    ];

    final List<Widget> tabViews = [
      CategoriaScreen(pedidoMesa: pedidoMesa),
      ResumenPedidoScreen(pedidoMesa: pedidoMesa),
      if (isHistorialEnabled) HistorialPedidoMesaScreen(pedidoMesa: pedidoMesa),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: tertiaryLight,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                  size: 30, // Ajusta el tamaño aquí
                ),
                onPressed: () {
                  pedidoProvider.pedidos.clear();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EntryPoint(initialIndex: 1),
                    ),
                    (route) => false,
                  );
                },
              ),
              title: const Text(
                'Volver a mesas',
                style: TextStyle(color: primaryColor, fontSize: 30),
              ),
              // centerTitle: true,
            ),
            body: Column(
              children: [
                SectionConnection(),
                Expanded(
                  child: NestedScrollView(
                    headerSliverBuilder: (
                      BuildContext context,
                      bool innerBoxIsScrolled,
                    ) {
                      return <Widget>[
                        SliverPersistentHeader(
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor: primaryMaterialColor[700],
                              unselectedLabelColor: primaryMaterialColor[400],
                              indicatorColor: tertiaryColor,
                              indicatorWeight: 3,
                              dividerColor: secondaryColor,
                              dividerHeight: 3,
                              tabs: tabs,
                            ),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(children: tabViews),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 10,
      shadowColor: secondaryColor,
      color: secondaryLight,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
