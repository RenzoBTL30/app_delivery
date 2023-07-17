import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/providers/rol.provider.dart';
import 'package:app_delivery/src/providers/usuario.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsuarioProvider usuarioProvider = UsuarioProvider();
  RolProvider rolProvider = RolProvider();

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String nombre = nameController.text;
    String apellidos = lastnameController.text;
    String celular = phoneController.text.trim();
    String contrasenia = passwordController.text.trim();
    String confirmContrasenia = confirmpasswordController.text.trim();

    

    print('Email ${email}');
    print('Password ${contrasenia}');

    if (isValidForm(email, nombre, apellidos, celular, contrasenia, confirmContrasenia)) {

      
      SimpleFontelicoProgressDialog progressDialog = SimpleFontelicoProgressDialog(context: context);
      progressDialog.show(message: '', type: SimpleFontelicoProgressDialogType.normal, horizontal: false, hideText: true);

      //-- Otra opcion: --
      //ProgressDialog progressDialog = ProgressDialog(context: context);
      //progressDialog.show(msg: 'Espera porfavor...',progressType: ProgressType.normal);

      //Redirigir a login
      Usuario usuario = Usuario(
        email: email,
        nombre: nombre,
        apellidos: apellidos,
        celular: celular,
        contrasenia: contrasenia
      );

      Response response = await usuarioProvider.create(usuario);

      rolProvider.asignarRol(response.body['id_usuario'], 3);

      progressDialog.hide();
      //progressDialog.close;
      
      print('RESPONSE: ${response.body}');
      goToLoginPage();
    }
  }

  void goToLoginPage() {
    Get.toNamed('/');
  }

  bool isValidForm(String email, String nombre, String apellidos, String celular, String contrasenia, String confirmContrasenia) {
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

    if (confirmContrasenia.isEmpty) {
      //message notification
      return false;
    }

    if (contrasenia.isEmpty) {
      //message notification
      return false;
    }

    if (contrasenia != confirmContrasenia) {
      //message notification
      return false;
    }

    return true;
  }
}