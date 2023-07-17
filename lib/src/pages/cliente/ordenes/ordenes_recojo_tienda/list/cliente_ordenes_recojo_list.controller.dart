import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClienteOrdenesRecojoListController extends GetxController {

  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {});

  OrdenProvider ordenProvider = OrdenProvider();
  List<String> estados = <String>['1', '2', '3'].obs;

  Future<List<Orden>> getOrdenes(String estado) async {
    return await ordenProvider.findByClienteRecojoAndStatus(usuario.idUsuario ?? '0',estado);
  }

  void goToOrdenDetalle (Orden orden, int index) {
    Get.toNamed('/cliente/ordenes/recojo/detalle', arguments: {
      'orden': orden.toJson(),
      'index': index
    });
  }
}