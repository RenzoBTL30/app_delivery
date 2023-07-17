import 'package:app_delivery/src/pages/admin/perfil/update_contra/admin_perfil_update_contra_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPerfilUpdateContraPage extends StatelessWidget {

  AdminPerfilUpdateContraController con = Get.put(AdminPerfilUpdateContraController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(),
          _buttonBack()
        ],
      )
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
      height: MediaQuery.of(context).size.height * 0.45,
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
          _titleBox(),
          _textFieldPassword(),
          _textFieldConfirmPassword(),
          _btnUpdate(context)
        ]),
      ),
    );
  }

  Widget _titleBox() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 25),
      child: Text(
        'Cambiar contraseña',
        style: TextStyle(color: Colors.black, fontSize: 22),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Nueva contraseña', prefixIcon: Icon(Icons.lock)),
      ),
    );
  }

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 3),
      child: TextField(
        controller: con.confirmpasswordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confirmar nueva contraseña', prefixIcon: Icon(Icons.lock_outline)),
      ),
    );
  }

  Widget _btnUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      color: Color(0xFFF2C447),
      child: ElevatedButton(
        onPressed: () => con.actualizarContra(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)),
        child: const Text(
          'Cambiar',
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ),
    );
  }
}