import 'package:flutter/material.dart';
import 'package:riccos/constants.dart';
import 'package:riccos/entry_point.dart';
import 'package:riccos/models/pedido_mesa_model.dart';
import 'package:riccos/providers/pedido_provider.dart';
import 'package:riccos/screens/categoria/views/categoria_screen.dart';
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
      const Tab(icon: Icon(Icons.home_rounded), text: "Seleccionar"),
      const Tab(icon: Icon(Icons.shopping_bag_rounded), text: "Resumen"),
      if (isHistorialEnabled)
        const Tab(icon: Icon(Icons.person), text: "Historial"),
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
              backgroundColor: secondaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                "VOLVER A MESAS",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0, // Opcional: elimina la sombra del AppBar
            ),
            body: Column(
              children: [
                SectionConnection(),
                Expanded(
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverPersistentHeader(
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor: tertiaryColor,
                              unselectedLabelColor: tertiaryColorS,
                              indicatorColor: tertiaryColor,
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
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
