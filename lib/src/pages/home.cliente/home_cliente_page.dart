import 'package:app_delivery/src/pages/home.cliente/home_cliente.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeClientePage extends StatelessWidget {

  HomeClienteController con = Get.put(HomeClienteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => con.signOut(),
          child: Text(
            'Cerrar sesión',
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}