import 'package:app_delivery/src/pages/admin/perfil/info/admin_perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPerfilPage extends StatelessWidget {

  AdminPerfilController con = Get.put(AdminPerfilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(),
          _buttonBack()
        ],
      ))
    );
  }

  Widget _buttonBack() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10),
        child: IconButton (
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
      )
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Color(0xFFF2C447),
    );
  }

  Widget _imageUser() {
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 35),
          alignment: Alignment.topCenter,
          child: CircleAvatar (
            backgroundImage: AssetImage('assets/images/user_profile.png'),
            radius: 60,
            backgroundColor: Colors.white,
          ),
        )
    ); 
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.30, left: 50, right: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(children: [
          _textNombre(),
          _textEmail(),
          _textCelular(),
          _btnUpdate(context),
          _btnUpdatePassword(context)
        ]),
      ),
    );
  }

  Widget _textNombre() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
          leading: Icon(Icons.person),
          title: Text('${con.usuario.value.nombre ?? ''} ${con.usuario.value.apellidos ?? ''}'),
          subtitle: Text('Nombre y apellidos'),
        )
    );
  }

  Widget _textEmail() {
    return ListTile(
        leading: Icon(Icons.email),
        title: Text(con.usuario.value.email ?? ''),
        subtitle: Text('Correo electrónico'),
    );
  }

  Widget _textCelular() {
    return ListTile(
        leading: Icon(Icons.phone),
        title: Text(con.usuario.value.celular ?? ''),
        subtitle: Text('Celular'),
    );
  }

  Widget _btnUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      color: Color(0xFFF2C447),
      child: ElevatedButton(
        onPressed: () => con.goToUpdateAdminPerfil(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)),
        child: const Text(
          'Actualizar datos',
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ),
    );
  }

  Widget _btnUpdatePassword(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      color: Color(0xFFF2C447),
      child: ElevatedButton(
        onPressed: () => con.goToUpdateAdminContrasenia(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)),
        child: const Text(
          'Cambiar contraseña',
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ),
    );
  }
}