import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DeliveryPerfilController extends GetxController {

  var usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {}).obs;

  void goToUpdateDeliveryPerfil() {
    Get.toNamed('/delivery/perfil/update');
  }

  void goToUpdateDeliveryContrasenia() {
    Get.toNamed('/delivery/perfil/updatecontra');
  }
}