import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/providers/rol.provider.dart';
import 'package:app_delivery/src/providers/usuario.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClienteRegistroPedidoCompletadoController extends GetxController {

  void goToInicioPage() {
    Get.offNamedUntil('/cliente/menuprincipal', (route) => false);
  }

  void goToMenuPrincipalOrdenes() {
    Get.offNamedUntil('/cliente/ordenes/menuprincipal', 
    (route) => false);
  }

}