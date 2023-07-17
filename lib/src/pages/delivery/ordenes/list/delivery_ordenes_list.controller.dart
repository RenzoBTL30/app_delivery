import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DeliveryOrdenesListController extends GetxController {

  var usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {}).obs;

  OrdenProvider ordenProvider = OrdenProvider();
  List<String> estados = <String>['2', '3'].obs;

  Future<List<Orden>> getOrdenes(String estado) async {
    return await ordenProvider.findByStatusToDelivery(estado);
  }

  void goToOrdenDetalle (Orden orden, int index) {
    Get.toNamed('/delivery/ordenes/detalle', arguments: {
      'orden': orden.toJson(),
      'index': index
    });
  }

  void signOut() {
    GetStorage().remove('usuario');
    Get.offNamedUntil('/', (route) => false);
  }

  void goToDeliveryPerfil() {
    Get.toNamed('/delivery/perfil/info');
  }

  /*void goToGestionarProductos() {
    Get.toNamed('/admin/gestionar/productos');
  }

  void goToGestionarPedidos() {
    Get.toNamed('/admin/ordenes/lista');
  }*/
}