import 'package:app_delivery/src/models/metodo_pago.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/pages/cliente/pagos/pagos.controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientePagosPage extends StatelessWidget {
  
  ClientePagosController con = Get.put(ClientePagosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buttonNext(context),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
          'Método de pago',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: GetBuilder<ClientePagosController>(
        builder: (value) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              _titleDetalle(),
              SizedBox(height: 20),
              _boxData(context),
              SizedBox(height: 30),
              _titleMetodoPago(),
              _listMetodoPago(context),
              SizedBox(height: 30),
              con.radioValue.value == 0 ? _textFieldBilletePago() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonNext(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
        onPressed: () => con.goToResumenPago(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Color(0xFFC42227)
        ),
        child: const Text(
          'Continuar',
          style: TextStyle(color: Colors.white, fontSize: 17),
        )
      ),
    );
  }

  Widget _boxData(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width * 0.8,
      //height: MediaQuery.of(context).size.height * 0.13,
      margin: EdgeInsets.only(
        left: 30, right: 30
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5,
            offset: Offset(0, 3), // Ajusta el valor del desplazamiento en el eje y
          ),
        ]
      ),
      child: Column(
        children: [

          SizedBox(height: 20),
          _dataSubtotal(),
          SizedBox(height: 10),
          con.d.comision == null ? Container()  : _dataComisionDelivery(), //Si d.comision es vacío (si se escogio Recojo en tienda), 
          con.d.comision == null ? Container() : SizedBox(height: 10),
          _dataTotal(),
          SizedBox(height: 20),
        ],
      )
    );
  }

  Widget _titleMetodoPago() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
          'Elige el método de pago:',
          style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _titleDetalle() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
          'Detalle del Pedido:',
          style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _dataSubtotal() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Text(
            'Subtotal:',
            style: TextStyle(
              fontSize: 16
            ),
          ),
          Spacer(),
          Text(
            'S/${con.subtotal.toStringAsFixed(2).toString()}',
            style: TextStyle(
              fontSize: 16
            ),
          ),
        ],
      )
    );
  }


  Widget _dataComisionDelivery() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
        Text(
          'Comisión:',
            style: TextStyle(
              fontSize: 16
            ),
        ),
        Spacer(),
        Text(
          'S/${con.d.comision?.toStringAsFixed(2).toString() ?? ''}',
          style: TextStyle(
            fontSize: 16
          ),
        ),
       ],
      )
    );
  }

  Widget _dataTotal() {
    return Container(
       margin: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
          Text(
            'Total',
            style: TextStyle(
              fontSize: 16
            ),
          ),
          Spacer(),
          Text(
            'S/${con.total.toStringAsFixed(2).toString()}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    );
  }

 Widget _listMetodoPago(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: FutureBuilder(
      future: con.getMetodosPago(),
      builder: (context, AsyncSnapshot<List<MetodoPago>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Column(
              children: snapshot.data!.asMap().entries.map((entry) {
                final index = entry.key;
                final metodoPago = entry.value ;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: _radioSelectorDireccion(metodoPago, index),
                );
              }).toList(),
            );
          } else {
            return Center(
              child: NoDataWidget(text: 'No hay métodos de pago'),
            );
          }
        } else {
          return Center(
            child: NoDataWidget(text: 'No hay métodos de pago'),
          );
        }
      },
    ),
  );
}

  Widget _radioSelectorDireccion(MetodoPago metodoPago, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: index,
                groupValue: con.radioValue.value,
                onChanged: con.handleRadioValueChange,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metodoPago.nombre ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }


  Widget _textFieldBilletePago() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Indica el billete con el que vas a pagar:',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 35),
          child: TextField(
            controller: con.billetePagoController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Máx. 100 caracteres', prefixIcon: Icon(Icons.edit)),
          ),
        )
      ],
    );
  }
}