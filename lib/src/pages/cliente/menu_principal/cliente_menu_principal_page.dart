import 'package:app_delivery/src/pages/cliente/cliente_inicio/cliente_inicio_page.dart';
import 'package:app_delivery/src/pages/cliente/direcciones_solo_lista/lista/direcciones_solo_lista_lista_page.dart';
import 'package:app_delivery/src/pages/cliente/menu_principal/cliente_menu_principal.controller.dart';
import 'package:app_delivery/src/pages/cliente/bolsa/create/cliente_ordenes_create_page.dart';
import 'package:app_delivery/src/pages/cliente/menu_principal_ordenes/menu_principal_ordenes_page.dart';
import 'package:app_delivery/src/pages/cliente/productos_lista/lista/cliente_productos_lista_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteMenuPrincipalPage extends StatelessWidget {

  ClienteMenuPrincipalController con = Get.put(ClienteMenuPrincipalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomBar(),
      body: Obx(() => IndexedStack(
        index: con.indexTab.value,
        children: [
          ClienteInicioPage(),
          ClienteProductosListaPage(),
          ClienteDireccionesSoloListaListaPage(),
          ClienteMenuPrincipalOrdenesPage()
        ],
      ))
    );
  }

  Widget _bottomBar() {
    return Obx(() =>  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: con.indexTab.value,
        selectedItemColor: Colors.amber[800],
        onTap: (index) => con.changeTab(index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Tienda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: 'Direcciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Pedidos',
          ),
        ],
    ));
  }
}