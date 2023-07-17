import 'package:app_delivery/src/pages/admin/admin_inicio/admin_inicio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminInicioPage extends StatelessWidget {

  AdminInicioController cont = Get.put(AdminInicioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Inicio',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Obx(() => Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                '${cont.usuario.value.nombre ?? ''} ${cont.usuario.value.apellidos ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                '${cont.usuario.value.email ?? ''}',
              ),
              currentAccountPicture:
                CircleAvatar (
                  backgroundImage: AssetImage('assets/images/user_profile.png'),
                  radius: 60,
                  backgroundColor: Colors.white,
                ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
              ),
              title: const Text('Mi Perfil'),
              onTap: () {
                cont.goToAdminPerfil();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('Cerrar sesión'),
              onTap: () {
                cont.signOut();
              },
            ),
          ],
        ),
      )),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            _btnGestionarPedidos(context),
          ],
        ),
      ),
      
    );
  }



  Widget _btnGestionarPedidos(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: ElevatedButton(
        onPressed: () => cont.goToGestionarPedidos(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          backgroundColor: Color(0xFFC42227),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Gestionar Pedidos',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

}