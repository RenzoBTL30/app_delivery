import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AdminPerfilController extends GetxController {

  var usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {}).obs;

  void goToUpdateAdminPerfil() {
    Get.toNamed('/admin/perfil/update');
  }

  void goToUpdateAdminContrasenia() {
    Get.toNamed('/admin/perfil/updatecontra');
  }
}