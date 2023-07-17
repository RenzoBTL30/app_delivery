import 'package:app_delivery/src/models/direccion.dart';
import 'package:app_delivery/src/models/forma_entrega.dart';
import 'package:app_delivery/src/models/lugar.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/lista/direcciones_lista_controller.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/map/direcciones_map_page.dart';
import 'package:app_delivery/src/providers/direccion.provider.dart';
import 'package:app_delivery/src/providers/forma_entrega.provider.dart';
import 'package:app_delivery/src/providers/lugar.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ClienteFormaEntregaController extends GetxController {

  List<FormaEntrega> formasEntrega = [];
  FormaEntregaProvider formaEntregaProvider = FormaEntregaProvider();
  
  //OrdenProvider ordenProvider = OrdenProvider();
  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {});

  var radioValue = 0.obs;

  Future<List<FormaEntrega>> getFormasEntrega() async {
    formasEntrega = await formaEntregaProvider.getFormasEntrega(); //Almacena todos los elementos en la lista formasEntrega
    FormaEntrega f = FormaEntrega.fromJson(GetStorage().read('formaentrega') ?? {}); // FormaEntrega SELECCIONADA POR EL USUARIO
    int index = formasEntrega.indexWhere((ad) => ad.idFormaEntrega == f.idFormaEntrega); // Compara los id de la FormaEntrega seleccionada por el usuario y los id de cada elemento de la lista y recupera el index
    print('Index: ${index}'); // este index normalmente es el mismo que el value de handleRadioValueChange 

    if (index != -1) { // SI LA FORMAENTREGA DE SESION COINCIDE CON UN ITEM DE LA LISTA, el radioValue del page toma el valor del index
      radioValue.value = index;
    }

    return formasEntrega;
  }

  void handleRadioValueChange(int? value) {
    radioValue.value = value!; // Recibe el valor del radioValue, en este caso, puede ser 0 o 1
    print('VALOR SELECCIONADO ${value}');
    GetStorage().write('formaentrega', formasEntrega[value].toJson()); // De la lista formasEntrega, almacena en el storage el item en la posicion (value) en formato Json
    print('FORMA DE ENTREGA DEL GETSTORAGE ${formasEntrega[value].toJson()}');
    update(); // Vuelve a hacer el GetBuilder del page (un refresh)
  }

  void goToDirecciones() {
    Get.toNamed('/cliente/direccion/lista');
  }

  void goToMetodoPago() {
    FormaEntrega ft = FormaEntrega.fromJson(GetStorage().read('formaentrega') ?? {});
    if (ft.descripcion == 'Recojo en tienda') {
      GetStorage().remove('direccion');
    };

    Get.toNamed('/cliente/pagos');
  }

}