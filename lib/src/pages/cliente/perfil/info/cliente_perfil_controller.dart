import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientePerfilController extends GetxController {

  var usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {}).obs;

  void goToUpdatePerfil() {
    Get.toNamed('/cliente/perfil/update');
  }

  void goToUpdateContrasenia() {
    Get.toNamed('/cliente/perfil/updatecontra');
  }
}