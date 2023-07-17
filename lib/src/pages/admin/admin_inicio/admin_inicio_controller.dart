import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AdminInicioController extends GetxController {
  
  var usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {}).obs;

  void signOut() {
    GetStorage().remove('usuario');
    Get.offNamedUntil('/', (route) => false);
  }

  void goToAdminPerfil() {
    Get.toNamed('/admin/perfil/info');
  }

  void goToGestionarProductos() {
    Get.toNamed('/admin/gestionar/productos');
  }

  void goToGestionarPedidos() {
    Get.toNamed('/admin/ordenes/lista');
  }
}