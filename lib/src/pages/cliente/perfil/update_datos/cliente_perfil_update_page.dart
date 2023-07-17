import 'package:app_delivery/src/pages/cliente/perfil/update_datos/cliente_perfil_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientePerfilUpdatePage extends StatelessWidget {

  ClientePerfilUpdateController con = Get.put(ClientePerfilUpdateController());

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
      height: MediaQuery.of(context).size.height * 0.55,
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
          _btnUpdate(context)
        ]),
      ),
    );
  }

  Widget _titleBox() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 25),
      child: Text(
        'Actualizar tus datos',
        style: TextStyle(color: Colors.black, fontSize: 22),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 3),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electrónico', prefixIcon: Icon(Icons.email)),
      ),
    );
  }


  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: con.nameController,
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
        controller: con.lastnameController,
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
        controller: con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Celular', prefixIcon: Icon(Icons.phone)),
      ),
    );
  }

  Widget _btnUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      color: Color(0xFFF2C447),
      child: ElevatedButton(
        onPressed: () => con.actualizar(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)),
        child: const Text(
          'Actualizar',
          style: TextStyle(color: Colors.black, fontSize: 17),
        )
      ),
    );
  }
}