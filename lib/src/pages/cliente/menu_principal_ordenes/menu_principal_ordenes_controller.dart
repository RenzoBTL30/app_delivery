import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClienteMenuPrincipalOrdenesController extends GetxController {
  
  var usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {}).obs;

  void goToMenuPrincipal() {
    Get.toNamed('/cliente/menuprincipal');
  }

  void goToListaOrdenesDelivery() {
    Get.toNamed('/cliente/ordenes/delivery/list');
  }

  void goToListaOrdenesRecojo() {
    Get.toNamed('/cliente/ordenes/recojo/list');
  }
}