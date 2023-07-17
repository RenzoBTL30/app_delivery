import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:app_delivery/src/providers/usuario.provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ClienteOrdenesRecojoDetalleController extends GetxController {

  Orden orden = Orden.fromJson(Get.arguments['orden']);
  int index = Get.arguments['index'];

  var total = 0.0.obs;
  //var idDelivery = ''.obs;

  UsuarioProvider usuarioProvider = UsuarioProvider();
  OrdenProvider ordenProvider = OrdenProvider();
  List<Usuario> usuarios = <Usuario>[].obs;

  ClienteOrdenesRecojoDetalleController() {
    print('Orden: ${orden.toJson()}');
    //getDeliveryMen();
    getTotal();
  } 

  void getTotal() {
    total.value = 0.0;
    orden.productos!.forEach((producto) {
      total.value = total.value + (producto.cantidad! * producto.precio!);
    });
  }

}