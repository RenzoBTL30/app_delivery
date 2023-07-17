import 'package:app_delivery/src/models/direccion.dart';
import 'package:app_delivery/src/models/forma_entrega.dart';
import 'package:app_delivery/src/models/lugar.dart';
import 'package:app_delivery/src/models/metodo_pago.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/lista/direcciones_lista_controller.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/map/direcciones_map_page.dart';
import 'package:app_delivery/src/providers/direccion.provider.dart';
import 'package:app_delivery/src/providers/forma_entrega.provider.dart';
import 'package:app_delivery/src/providers/lugar.provider.dart';
import 'package:app_delivery/src/providers/metodo_pago.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ClientePagosController extends GetxController {

  List<MetodoPago> metodosPago = [];
  MetodoPagoProvider metodoPagoProvider = MetodoPagoProvider();

  TextEditingController billetePagoController = TextEditingController();

  List<Producto> productos = [];
  var result = GetStorage().read('bolsa_compras');
  Direccion d = Direccion.fromJson(GetStorage().read('direccion') ?? {}) ; //Sera null si la forma de entrega es "Recojo en Tienda"
  
  //OrdenProvider ordenProvider = OrdenProvider();
  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {});

  var radioValue = 0.obs;

  double subtotal = 0.0;
  double total = 0.0;


  ClientePagosController() {
    print(result);
    //productos = Producto.fromJsonList(result).toList();

    if (GetStorage().read('bolsa_compras') is List<Producto>) {
      productos = GetStorage().read('bolsa_compras');
    }
    else {
      productos = Producto.fromJsonList(GetStorage().read('bolsa_compras'));
    }

    update();
    getSubTotal(productos);
    getTotal();
    radioValue.value = -1;
  }

  Future<List<MetodoPago>> getMetodosPago() async {
    metodosPago = await metodoPagoProvider.getMetodosPago();


    MetodoPago m = MetodoPago.fromJson(GetStorage().read('metodopago') ?? {});
    int index = metodosPago.indexWhere((ad) => ad.idMetodoPago == m.idMetodoPago);

    print('RadioValue: ${radioValue.value}');
    print('Index: ${index}');
    print('Opcion metodo seleccionado: ${m.nombre}');
    

    return metodosPago;
  }

  

  void handleRadioValueChange(int? value) {
    radioValue.value = value!; // Recibe el valor del radioValue, en este caso, puede ser 0 o 1
    print('VALOR SELECCIONADO ${value}');
    GetStorage().write('metodopago', metodosPago[value].toJson());
    update();
  }

  void getSubTotal(productos) {
    subtotal = 0.0;
    productos.forEach((p) { 
      subtotal = subtotal + (p.cantidad! * p.precio!);
    });
    //print(d.lugar);
    //print(d.comision);
  }

  void getTotal() {
    //print(d.comision?.toDouble());
    total = subtotal + (d.comision?.toDouble() ?? 0); //d.comision llegara null cuando la opcion de la forma de entrega sea "Recojo en Tienda"
  }

  void goToResumenPago() {
    if (isValidRadioMetodoPago()) {
      Get.toNamed('/cliente/resumenpago', arguments: {'billetePago': billetePagoController.text},);
    }
  }


  bool isValidRadioMetodoPago() {
    if (radioValue.value == -1){
      Get.snackbar('Error', 'Debes seleccionar un método de pago');
      //Fluttertoast.showToast(msg: 'Debes seleccionar un método de pago', toastLength: Toast.LENGTH_LONG);
      return false;

    } else if (radioValue.value == 0 && billetePagoController.text == '') {
      Get.snackbar('Error', 'Debes indicar el billete de pago');
      //Fluttertoast.showToast(msg: 'Debes colocar el billete de pago', toastLength: Toast.LENGTH_LONG);
      return false;
    }
    return true;
  }

}