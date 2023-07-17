import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/providers/usuario.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ClientePerfilUpdateContraController extends GetxController {

  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario'));

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  UsuarioProvider usuarioProvider = UsuarioProvider();

  void actualizarContra(BuildContext context) async {
    String contrasenia = passwordController.text.trim();
    String confirmContrasenia = confirmpasswordController.text.trim();

    if (isValidForm(contrasenia, confirmContrasenia)) {

      SimpleFontelicoProgressDialog progressDialog = SimpleFontelicoProgressDialog(context: context);
      progressDialog.show(message: '', type: SimpleFontelicoProgressDialogType.normal, horizontal: false, hideText: true);

      Usuario miUsuario = Usuario(
        idUsuario: usuario.idUsuario,
        contrasenia: contrasenia
      );

      ResponseApi responseApi = await usuarioProvider.actualizarContra(miUsuario);
      Get.snackbar('Actualización completa', responseApi.message ?? '');
      progressDialog.hide();
      goToClientePerfil();

    }
  }

  bool isValidForm(String contrasenia, String confirmContrasenia) {

    if (confirmContrasenia.isEmpty) {
      //message notification
      return false;
    }

    if (contrasenia != confirmContrasenia) {
      //message notification
      return false;
    }

    if (contrasenia.isEmpty) {
      //message notification
      return false;
    }

    return true;
  }

  void goToClientePerfil() {
    Get.toNamed('/cliente/perfil/info');
  }

}