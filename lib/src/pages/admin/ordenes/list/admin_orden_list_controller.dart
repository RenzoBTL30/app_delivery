import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:get/get.dart';

class AdminOrdenListController extends GetxController {

  OrdenProvider ordenProvider = OrdenProvider();
  List<String> estados = <String>['1', '2', '3'].obs;

  Future<List<Orden>> getOrdenes(String estado) async {
    return await ordenProvider.findByStatus(estado);
  }

  void goToOrdenDetalle (Orden orden, int index) {
    Get.toNamed('/admin/ordenes/detalle', arguments: {
      'orden': orden.toJson(),
      'index': index
    });
  }
}