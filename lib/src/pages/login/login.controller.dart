import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/providers/usuario.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class LoginController extends GetxController {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsuarioProvider usuarioProvider = UsuarioProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login(BuildContext context) async {
    String email = emailController.text.trim(); //Valida que no haya espacios en blanco
    String contrasenia = passwordController.text.trim(); //Valida que no haya espacios en blanco

    ProgressDialog progressDialog = ProgressDialog(context: context);

    print('Email ${email}');
    print('Password ${contrasenia}');

    if (isValidForm(email, contrasenia)) {

      progressDialog.show(msg: 'Iniciando sesión...');

      ResponseApi responseApi = await usuarioProvider.login(email, contrasenia);

      
      print('Response to: ${responseApi.toJson()}');
      progressDialog.close();

      if (responseApi.success == true) {
        progressDialog.close();
        GetStorage().write('usuario', responseApi.data);
        progressDialog.close();
        if (responseApi.data['rol'] == 'Cliente') {
          goToClienteMenuPrincipalPage();
        } else if (responseApi.data['rol'] == 'Delivery') {
          goToDeliveryOrdenesListPage();
        } else if (responseApi.data['rol'] == 'Administrador') {
          goToAdminMenuPrincipalPage();
        }

      } else {
        Get.snackbar('Login fallido', responseApi.message ?? ''); //El ?? valida si es null el responseApi.message
      }
    }
  }

  void goToHomeClientePage() {
    Get.offNamedUntil('/homecliente', (route) => false);
  }

  void goToClienteMenuPrincipalPage() {
    Get.offNamedUntil('/cliente/menuprincipal', (route) => false);
  }

  void goToDeliveryOrdenesListPage() {
    Get.offNamedUntil('/delivery/ordenes/list', (route) => false);
  }

  void goToAdminMenuPrincipalPage() {
    Get.offNamedUntil('/admin/menuprincipal', (route) => false);
  }

  bool isValidForm(String email, String contrasenia) {
    if (email.isEmpty) {
      //message notification
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      //message notification
      return false;
    }

    if (contrasenia.isEmpty) {
      //message notification
      return false;
    }

    return true;
  }

}