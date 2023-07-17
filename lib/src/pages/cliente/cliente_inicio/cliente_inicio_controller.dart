import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClienteInicioController extends GetxController {

  var usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {}).obs;

  void signOut() {
    GetStorage().remove('direccion');
    GetStorage().remove('bolsa_compras');
    GetStorage().remove('usuario');
    Get.offNamedUntil('/', (route) => false);
  }

  void goToPerfilInfo() {
    Get.toNamed('/cliente/perfil/info');
  }

  void goToPromocionesLista() {
    Get.toNamed('/cliente/registropedidocomplete');
  }

  void goToDescuentos() {
    Get.toNamed('/cliente/descuentos');
  }
}