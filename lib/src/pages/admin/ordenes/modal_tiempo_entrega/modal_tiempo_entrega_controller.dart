import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ModalTiempoEntregaController extends GetxController {
  
  TextEditingController tiempoController = TextEditingController();
  OrdenProvider ordenProvider = OrdenProvider();

  void regresarPantallaAnterior(BuildContext context) {
    Navigator.pop(context);
  }

  void inserttiempo(BuildContext context, String idOrden) async {
    String tiempoEntrega = tiempoController.text;

    if (isValidForm(tiempoEntrega)) {

      ResponseApi responseApi = await ordenProvider.insertTiempoEntrega(idOrden,tiempoEntrega);


      if (responseApi.success == true) {
        Fluttertoast.showToast(msg: 'Tiempo de entrega insertado', toastLength: Toast.LENGTH_LONG);
        regresarPantallaAnterior(context);
        limpiar();
      }
    }
  }

  bool isValidForm(String nombre) {

    if (nombre.isEmpty) {
      //message notification
      return false;
    }
 
    return true;
  }

  limpiar() {
    tiempoController.text = '';
  }

}