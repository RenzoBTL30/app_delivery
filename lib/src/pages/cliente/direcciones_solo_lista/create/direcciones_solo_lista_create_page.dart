import 'dart:io';
import 'package:app_delivery/src/models/lugar.dart';
import 'package:app_delivery/src/pages/cliente/direcciones_solo_lista/create/direcciones_solo_lista_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteDireccionesSoloListaCreatePage extends StatelessWidget {

  ClienteDireccionesSoloListaCreateController con = Get.put(ClienteDireccionesSoloListaCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // POSICIONAR ELEMENTOS UNO ENCIMA DEL OTRO
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _textNewAddress(context),
          _iconBack()
        ],
      ),
    );
  }

  Widget _iconBack() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 15),
        child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, size: 30,)
        ),
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldAddress(),
            _textFieldRefPoint(context),
            _dropDownLugares(con.lugares),
            SizedBox(height: 20),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }



  Widget _textFieldAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.direccionController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Dirección',
            prefixIcon: Icon(Icons.location_on)
        ),
      ),
    );
  }

  Widget _textFieldRefPoint(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        onTap: () => con.openGoogleMaps(context),
        controller: con.puntoReferenciaController,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Punto de referencia',
            prefixIcon: Icon(Icons.map)
        ),
      ),
    );
  }


  Widget _dropDownLugares(List<Lugar> lugares) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          'Seleccionar Lugar',
          style: TextStyle(

            fontSize: 15
          ),
        ),
        items: _dropDownItems(lugares),
        value: con.idLugar.value == '' ? null : con.idLugar.value,
        onChanged: (option) {
          print('Opcion seleccionada ${option}');
          con.idLugar.value = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Lugar> lugares) {
    List<DropdownMenuItem<String>> list = [];
    lugares.forEach((lugar) {
      list.add(DropdownMenuItem(
          child: Text(lugar.lugar ?? ''),
          value: lugar.idLugar,
      ));
    });

    return list;
  }



  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
          onPressed: () {
            con.createAddress();
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'CREAR DIRECCION',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _textNewAddress(BuildContext context) {

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Icon(Icons.location_on, size: 100),
            Text(
              'NUEVA DIRECCION',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: Text(
        'INGRESA ESTA INFORMACION',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}