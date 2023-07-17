import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/pages/admin/ordenes/modal_tiempo_entrega/modal_tiempo_entrega_controller.dart';
import 'package:app_delivery/src/pages/cliente/productos_lista/detalle/cliente_productos_detalle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModalTiempoEntregaPage extends StatelessWidget {

  //ModalTiempoEntregaController con = Get.put(ModalTiempoEntregaController());

  late ModalTiempoEntregaController con;
  var idOrden;


  ModalTiempoEntregaPage({required String this.idOrden}) {
    con = Get.put(ModalTiempoEntregaController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          SizedBox(height: 45),
          _titleField(),
          _textTiempo(),
          _btnTiempo(context, idOrden)
        ]
      )
    );
  }


  Widget _titleField() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 25),
      child: Text(
        'Tiempo de entrega:',
        style: TextStyle(color: Colors.black, fontSize: 22),
      ),
    );
  }

  Widget _textTiempo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: con.tiempoController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Ingresar', prefixIcon: Icon(Icons.timelapse)),
      ),
    );
  }

  Widget _btnTiempo(BuildContext context, String idOrden) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      color: Color(0xFFC42227),
      child: ElevatedButton(
        onPressed: () => con.inserttiempo(context, idOrden),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Color(0xFFC42227),
        ),
        child: const Text(
          'Registrar',
          style: TextStyle(color: Colors.white, fontSize: 17),
        )
      ),
    );
  }
}