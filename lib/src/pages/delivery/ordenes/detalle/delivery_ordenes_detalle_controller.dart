import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:app_delivery/src/providers/usuario.provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DeliveryOrdenesDetalleController extends GetxController {

  Orden orden = Orden.fromJson(Get.arguments['orden']);
  int index = Get.arguments['index'];

  var total = 0.0.obs;
  //var idDelivery = ''.obs;

  UsuarioProvider usuarioProvider = UsuarioProvider();
  OrdenProvider ordenProvider = OrdenProvider();
  List<Usuario> usuarios = <Usuario>[].obs;

  DeliveryOrdenesDetalleController() {
    print('Orden: ${orden.toJson()}');
    //getDeliveryMen();
    getTotal();
  } 
  
  
  void updateOrder() async {

    ResponseApi responseApi = await ordenProvider.actualizarToEntregado(orden,'3');
    Fluttertoast.showToast(msg: 'La orden se actualizó a Entregado correctamente', toastLength: Toast.LENGTH_LONG);
    if (responseApi.success == true) {
      Get.offNamedUntil('/delivery/ordenes/list', (route) => false);
    }


    /*
    if (idDelivery.value != '') { // SI SELECCIONO EL DELIVERY
      
    }
    else {
      Get.snackbar('Peticion denegada', 'Debes asignar el repartidor');
    }*/
  }

  void goToOrderMap() {
    Get.toNamed('/delivery/ordenes/map', arguments: {
      'orden': orden.toJson()
    });
  }


  

  void getTotal() {
    total.value = 0.0;
    orden.productos!.forEach((producto) {
      total.value = total.value + (producto.cantidad! * producto.precio!);
    });
  }

}