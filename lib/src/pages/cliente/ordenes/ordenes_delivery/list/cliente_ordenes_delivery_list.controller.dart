import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClienteOrdenesDeliveryListController extends GetxController {

  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {});

  OrdenProvider ordenProvider = OrdenProvider();
  List<String> estados = <String>['1', '2', '3'].obs;

  Future<List<Orden>> getOrdenes(String estado) async {
    return await ordenProvider.findByClienteDeliveryAndStatus(usuario.idUsuario ?? '0',estado);
  }

  void goToOrdenDetalle (Orden orden, int index) {
    Get.toNamed('/cliente/ordenes/delivery/detalle', arguments: {
      'orden': orden.toJson(),
      'index': index
    });
  }

  void cancelarOrden(String idOrden, String estado) async {

    ResponseApi responseApi = await ordenProvider.cancelarOrden(idOrden);
    if (responseApi.success == true) {
      Fluttertoast.showToast(msg: 'La orden se canceló correctamente', toastLength: Toast.LENGTH_LONG);
      update();
    }

    await getOrdenes('1');

  }

  void mostrarDialogo(BuildContext context, String idOrden, String estado) {
  showDialog(
    context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Estas seguro de cancelar la orden?'),
          content: Text('No podrás deshacer este cambio'),
          actions: [
            TextButton(
              onPressed: () {
                cancelarOrden(idOrden, estado);
                Navigator.of(context).pop();
              },
              child: Text(
                'Si',
                style: TextStyle(
                  color: Colors.blue[700]
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.blue[700]
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}