import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/pages/delivery/ordenes/list/delivery_ordenes_list.controller.dart';
import 'package:app_delivery/src/pages/delivery/perfil/info/delivery_perfil_controller.dart';
import 'package:app_delivery/src/providers/usuario.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class DeliveryPerfilUpdateController extends GetxController {

  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {});
  UsuarioProvider usuarioProvider = UsuarioProvider();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  
  DeliveryPerfilController deliveryPerfilController = Get.find();
  DeliveryOrdenesListController deliveryOrdenesListController = Get.find();

  DeliveryPerfilUpdateController() {
    //print('USER SESION: ${GetStorage().read('usuario')}');
    emailController.text = usuario.email ?? '';
    nameController.text = usuario.nombre ?? '';
    lastnameController.text = usuario.apellidos ?? '';
    phoneController.text = usuario.celular ?? '';
  }

  void actualizar(BuildContext context) async {
    String email = emailController.text;
    String nombre = nameController.text;
    String apellidos = lastnameController.text;
    String celular = phoneController.text.trim();

    if (isValidForm(email, nombre, apellidos, celular)) {

      SimpleFontelicoProgressDialog progressDialog = SimpleFontelicoProgressDialog(context: context);
      progressDialog.show(message: '', type: SimpleFontelicoProgressDialogType.normal, horizontal: false, hideText: true);

      Usuario miUsuario = Usuario(
        idUsuario: usuario.idUsuario,
        email: email,
        nombre: nombre,
        apellidos: apellidos,
        celular: celular,
        sessionToken: usuario.sessionToken
      );

      ResponseApi responseApi = await usuarioProvider.actualizar(miUsuario);
      Get.snackbar('Actualización completa', responseApi.message ?? '');
      print('Response Api update este: ${responseApi.data}');
      progressDialog.hide();
      goToDeliveryPerfil();
      
      if (responseApi.success == true) {
        GetStorage().write('usuario', responseApi.data);
        deliveryPerfilController.usuario.value = Usuario.fromJson(GetStorage().read('usuario') ?? {});
        deliveryOrdenesListController.usuario.value = Usuario.fromJson(GetStorage().read('usuario') ?? {});
      }
    }
  }

  bool isValidForm(String email, String nombre, String apellidos, String celular) {

    if (email.isEmpty) {
      //message notification
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      //message notification
      return false;
    }

    if (nombre.isEmpty) {
      //message notification
      return false;
    }

    if (apellidos.isEmpty) {
      //message notification
      return false;
    }

    if (celular.isEmpty) {
      //message notification
      return false;
    }

    return true;
  }

  void goToDeliveryPerfil() {
    Get.toNamed('/delivery/perfil/info');
  }

}