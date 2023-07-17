import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/pages/cliente/cliente_inicio/cliente_inicio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ClienteInicioPage extends StatelessWidget {

  ClienteInicioController con = Get.put(ClienteInicioController());
  
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
                '${con.usuario.value.nombre ?? ''} ${con.usuario.value.apellidos ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                '${con.usuario.value.email ?? ''}',
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
                con.goToPerfilInfo();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('Cerrar sesión'),
              onTap: () {
                con.signOut();
              },
            ),
          ],
        ),
      )),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  FadeInImage(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/images/no-image.png'), 
                    image: AssetImage('assets/images/imagen-portada.jpg'), 
                  ),
                ],
              ),
              Column(
                children: [
                  _boxPresentacion(context),
                  SizedBox(height: 15),
                  _buttonDescuentos(context)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _boxPresentacion(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.13,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.25, left: 50, right: 50
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hola, ${con.usuario.value.nombre ?? ''}',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Text(
            'Bienvenido',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    );
  }

  Widget _buttonDescuentos(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ElevatedButton(
        onPressed: () => con.goToDescuentos(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          backgroundColor: Color(0xFF157F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity, // Fija el ancho mínimo del botón
            maxWidth: double.infinity, // Fija el ancho máximo del botón
            maxHeight: 80, // Fija el ancho máximo del botón
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Programa',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'de Puntos',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(width: 35), // Espacio entre FadeInImage y el Text
              FadeInImage(
                placeholder: AssetImage('assets/images/no-image.png'),
                image: AssetImage('assets/images/imagen-descuento.png'),
                width: 120,
                height: 120,
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}