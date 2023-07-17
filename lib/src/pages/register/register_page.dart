import 'package:app_delivery/src/pages/register/registrer.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {

  RegisterController regcont = Get.put(RegisterController());

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
      height: MediaQuery.of(context).size.height * 0.66,
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
          _textFieldEmail(),
          _textFieldName(),
          _textFieldLastName(),
          _textFieldPhone(),
          _textFieldPassword(),
          _textFieldConfirmPassword(),
          _btnRegister(context)
        ]),
      ),
    );
  }

  Widget _titleBox() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 25),
      child: Text(
        'Ingresa tus datos',
        style: TextStyle(color: Colors.black, fontSize: 22),
      ),
    );
  }


  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: regcont.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre', prefixIcon: Icon(Icons.person)),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: (EdgeInsets.symmetric(horizontal: 35, vertical: 3)),
      child: TextField(
        controller: regcont.lastnameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Apellidos', prefixIcon: Icon(Icons.person_outline)),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: regcont.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Celular', prefixIcon: Icon(Icons.phone)),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 3),
      child: TextField(
        controller: regcont.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electrónico', prefixIcon: Icon(Icons.email)),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: regcont.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Contraseña', prefixIcon: Icon(Icons.lock)),
      ),
    );
  }

  Widget _textFieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 3),
      child: TextField(
        controller: regcont.confirmpasswordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confirmar contraseña', prefixIcon: Icon(Icons.lock_outline)),
      ),
    );
  }

  Widget _btnRegister(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      color: Color(0xFFF2C447),
      child: ElevatedButton(
        onPressed: () => regcont.register(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)
        ),
        child: const Text(
          'Registrarse',
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ),
    );
  }
}