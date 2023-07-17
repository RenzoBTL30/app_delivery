import 'package:app_delivery/src/pages/cliente/registro_pedido_completado/registro_pedido_completado_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteRegistroPedidoCompletadoPage extends StatelessWidget {

  ClienteRegistroPedidoCompletadoController con = Get.put(ClienteRegistroPedidoCompletadoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(),
        ],
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
                  'assets/images/logo-correcto.png',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100, // Ajusta el tamaño de la imagen sin distorsionarla
                ),
              ),
            ),
          )
      ); 
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.30, left: 50, right: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(children: [
          _titleBox(),
          _infoPedidoCompletado(),
          _btnGoToInicio()
        ]),
      ),
    );
  }

  Widget _titleBox() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 25, left: 23, right: 23),
      child: Column(
        children: [
          Container(
            child: Text(
              'Pedido creado correctamente',
              style: TextStyle(
                color: Colors.black, 
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      )      
    );
  }

  Widget _infoPedidoCompletado() {
    return Container(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8, left: 9, right: 9),
            child: Text(
              'Puedes ver el estado de tu pedido en la sección de Pedidos que se encuentra en el Inicio de la app',
              style: TextStyle(
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnGoToInicio() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 40, right: 40, top: 20),
      color: Color(0xFFF2C447),
      child: ElevatedButton(
        onPressed: () => con.goToInicioPage(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)
        ),
        child: const Text(
          'Ir a Inicio',
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ),
    );
  }
}