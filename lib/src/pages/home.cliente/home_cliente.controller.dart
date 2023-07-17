import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeClienteController extends GetxController {
  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {});

  HomeClienteController() {
    print('USUARIO DE SESION: ${usuario.toJson()}');
  }

  void signOut() {
    GetStorage().remove('usuario');
    Get.offNamedUntil('/', (route) => false);
  }
}