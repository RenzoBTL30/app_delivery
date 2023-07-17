import 'package:app_delivery/src/models/direccion.dart';
import 'package:app_delivery/src/models/forma_entrega.dart';
import 'package:app_delivery/src/models/lugar.dart';
import 'package:app_delivery/src/models/metodo_pago.dart';
import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/lista/direcciones_lista_controller.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/map/direcciones_map_page.dart';
import 'package:app_delivery/src/providers/direccion.provider.dart';
import 'package:app_delivery/src/providers/forma_entrega.provider.dart';
import 'package:app_delivery/src/providers/lugar.provider.dart';
import 'package:app_delivery/src/providers/metodo_pago.provider.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ClienteResumenPagoController extends GetxController {

  List<MetodoPago> metodosPago = [];
  MetodoPagoProvider metodoPagoProvider = MetodoPagoProvider();

  var billetePago = Get.arguments['billetePago'].toString();

  List<Producto> productos = [];
  var result = GetStorage().read('bolsa_compras');
  Direccion d = Direccion.fromJson(GetStorage().read('direccion') ?? {}) ;
  FormaEntrega f = FormaEntrega.fromJson(GetStorage().read('formaentrega') ?? {}) ;
  MetodoPago m = MetodoPago.fromJson(GetStorage().read('metodopago') ?? {}) ;

  

  OrdenProvider ordenProvider = OrdenProvider();
  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {});

  var radioValue = 0.obs;
  double subtotal = 0.0;
  double total = 0.0;

  Future<List<MetodoPago>> getMetodosPago() async {
    metodosPago = await metodoPagoProvider.getMetodosPago();
    MetodoPago m = MetodoPago.fromJson(GetStorage().read('metodopago') ?? {});
    int index = metodosPago.indexWhere((ad) => ad.idMetodoPago == m.idMetodoPago);

    if (index != -1) {
      radioValue.value = index;
    }

    return metodosPago;
  }

  ClienteResumenPagoController() {
    print(result);
    //productos = Producto.fromJsonList(result).toList();

    if (GetStorage().read('bolsa_compras') is List<Producto>) {
      productos = GetStorage().read('bolsa_compras');
    }
    else {
      productos = Producto.fromJsonList(GetStorage().read('bolsa_compras'));
    }

    getSubTotal(productos);
    getTotal();
  }

  

  void createOrden() async {
    
    FormaEntrega f = FormaEntrega.fromJson(GetStorage().read('formaentrega') ?? {}) ;
    MetodoPago m = MetodoPago.fromJson(GetStorage().read('metodopago') ?? {}) ;

    Direccion d = Direccion.fromJson(GetStorage().read('direccion') ?? {}) ;

    List<Producto> productos = [];

    if (GetStorage().read('bolsa_compras') is List<Producto>) {
      productos = GetStorage().read('bolsa_compras');
    }
    else {
      productos = Producto.fromJsonList(GetStorage().read('bolsa_compras'));
    }

    Orden orden = Orden(
      idUsuario: usuario.idUsuario,
      idDireccion: d.idDireccion, //Si viene null o vacio el idDirección, se envia como dato el ''
      idMetodoPago: m.idMetodoPago,
      idFormaEntrega: f.idFormaEntrega,
      billetePago: billetePago,
      subtotal: subtotal,
      total: total,
      productos: productos
    );

    ResponseApi responseApi = await ordenProvider.create(orden);

    Fluttertoast.showToast(msg: 'Pedido registrado correctamente', toastLength: Toast.LENGTH_LONG);

    if (responseApi.success == true) {
      GetStorage().remove('bolsa_compras');
      GetStorage().remove('metodopago');
      GetStorage().remove('formaentrega');
      goToPedidoConfirmado();
    }
  }

  void getSubTotal(productos) {
    subtotal = 0.0;
    productos.forEach((p) { 
      subtotal = subtotal + (p.cantidad! * p.precio!);
    });
  }

  void getTotal() {
    total = subtotal + (d.comision?.toDouble() ?? 0);
  }

  void goToPedidoConfirmado() {
    Get.offNamedUntil('/cliente/registropedidocomplete', (route) => false);
  }

  void mostrarDialogoCancel(BuildContext context) {
  showDialog(
    context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Estas seguro de cancelar la orden?'),
          content: Text('No podrás deshacer este cambio'),
          actions: [
            TextButton(
              onPressed: () {
                cancelar();
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

  void cancelar() {
    Fluttertoast.showToast(msg: 'Pedido cancelado correctamente', toastLength: Toast.LENGTH_LONG);
    GetStorage().remove('bolsa_compras');
    GetStorage().remove('metodopago');
    GetStorage().remove('formaentrega');
    Get.offNamedUntil('/cliente/menuprincipal', (route) => false);
  }

}