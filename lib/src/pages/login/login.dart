import 'dart:ui';
import 'package:app_delivery/src/pages/login/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {

  LoginController cont = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textoNoTengoCuenta(),
      ),
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column(
            children: [_imageCover()],
          )
        ],
      )
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Color(0xFFF2C447),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.33, left: 50, right: 50),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Column(children: [
          _titleBox(),
          _textFieldEmail(),
          _textFieldPassword(),
          _btnLogin(context)
        ]),
      ),
    );
  }

  Widget _titleBox() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 45),
      child: Text(
        'BIENVENIDO',
        style: TextStyle(color: Colors.black, fontSize: 22),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: cont.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electrónico', prefixIcon: Icon(Icons.email)),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: TextField(
        controller: cont.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Contraseña', prefixIcon: Icon(Icons.lock)),
      ),
    );
  }

  Widget _btnLogin(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      color: Color(0xFFF2C447),
      child: ElevatedButton(
        onPressed: () => cont.login(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ),
    );
  }

  Widget _textoNoTengoCuenta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta?',
          style: TextStyle(
            color: Colors.black, 
            fontSize: 16
          ),
        ),
        SizedBox(width: 7),
        GestureDetector(
          onTap: () => cont.goToRegisterPage(),
          child: Text(
            'Registrate aquí',
            style: TextStyle(
              color: Color(0xFFF2C447),
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
        )
      ],
    );
  }

  // Private method for the _
  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo-paycha.png',
          width: 180,
          height: 180,
        ),
      ),
    );
  }
}
