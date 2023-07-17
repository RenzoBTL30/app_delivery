import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/pages/admin/ordenes/modal_tiempo_entrega/modal_tiempo_entrega_page.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:app_delivery/src/providers/usuario.provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AdminOrdenDetalleController extends GetxController {

  Orden orden = Orden.fromJson(Get.arguments['orden']);
  int index = Get.arguments['index'];

  var total = 0.0.obs;
  //var idDelivery = ''.obs;

  UsuarioProvider usuarioProvider = UsuarioProvider();
  OrdenProvider ordenProvider = OrdenProvider();
  List<Usuario> usuarios = <Usuario>[].obs;

  AdminOrdenDetalleController() {
    print('Orden: ${orden.toJson()}');
    //getDeliveryMen();
    getTotal();
  } 
  
  void updateOrder() async {

    ResponseApi responseApi = await ordenProvider.actualizarToEntregado(orden,'3');
    Fluttertoast.showToast(msg: 'La orden se actualizó a Entregado correctamente', toastLength: Toast.LENGTH_LONG);
    if (responseApi.success == true) {
      Get.offNamedUntil('/admin/ordenes/lista', (route) => false);
    }


    /*
    if (idDelivery.value != '') { // SI SELECCIONO EL DELIVERY
      
    }
    else {
      Get.snackbar('Peticion denegada', 'Debes asignar el repartidor');
    }*/
  }

  void getTotal() {
    total.value = 0.0;
    orden.productos!.forEach((producto) {
      total.value = total.value + (producto.cantidad! * producto.precio!);
    });
  }

  void openBottomSheet(BuildContext context, String idOrden) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ModalTiempoEntregaPage(idOrden: idOrden)
    );
  }

}