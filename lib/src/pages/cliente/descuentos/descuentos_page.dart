import 'package:app_delivery/src/pages/cliente/descuentos/descuentos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteDescuentosPage extends StatelessWidget {

  ClienteDescuentosController con = Get.put(ClienteDescuentosController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              _backgroundCover(context),
              Column(
                children: [
                  _boxPresentacion(context),
                  SizedBox(height: 45),
                  _infoDescuento()
                ],
              ),
              _imageUser(),
              _buttonBack()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buttonBack() {
      return SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10),
          child: IconButton (
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
        )
      );
    }

  Widget _backgroundCover(BuildContext context) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        color: Color(0xFFF2C447),
      );
    }

    Widget _imageUser() {
      return SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 45),
            alignment: Alignment.topCenter,
            child: CircleAvatar (
              radius: 60,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo-descuento.png',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100, // Ajusta el tamaño de la imagen sin distorsionarla
                ),
              ),
            ),
          )
      ); 
    }

  Widget _boxPresentacion(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.13,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.30, left: 50, right: 50
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
            'Haz acumulado:',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Text(
            '50 puntos',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    );
  }

  Widget _infoDescuento() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 23),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              '1. ¿Qué es el Programa de Puntos?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Text(
              'Son puntos de descuento que puedes canjearlos por los diferentes productos, por registrarte en la app recibes 20 puntos.',
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              '2. ¿Cómo acumular puntos?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              'Cada compra te permite acumular puntos:',
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8, left: 16),
            child: Text(
              '1 sol = 1 punto',
              style: TextStyle(
                fontSize: 16
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8, left: 16),
            child: Text(
              '2 soles = 2 puntos',
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
        ],
      ),
    );
  }
}