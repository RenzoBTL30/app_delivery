import 'package:app_delivery/src/models/forma_entrega.dart';
import 'package:app_delivery/src/models/lugar.dart';
import 'package:app_delivery/src/pages/cliente/forma_entrega/cliente_forma_entrega_controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteFormaEntregaPage extends StatelessWidget {

  ClienteFormaEntregaController con = Get.put(ClienteFormaEntregaController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: _buttonNext(context),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
          'Forma de Entrega',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: GetBuilder<ClienteFormaEntregaController> ( builder: (value) => Stack(
        children: [
          _textSelectFormaEntrega(),
          _listFormaEntrega(context)
        ],
      )),
    );
  }

  Widget _buttonNext(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
        //onPressed: () => con.createOrden(),
        onPressed: () => con.radioValue == 0 ? con.goToMetodoPago() : // radiovalue es 0 si es recojo en tienda
                         con.radioValue == 1 ? con.goToDirecciones() : {}, // radiovalue es 1 si es delivery
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

  Widget _listFormaEntrega(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 70),
      child: FutureBuilder(
          future: con.getFormasEntrega(),
          builder: (context, AsyncSnapshot<List<FormaEntrega>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    itemBuilder: (_, index) {
                      return _radioSelectorDireccion(snapshot.data![index], index);
                    }
                );
              }
              else {
                return Center(
                  child: NoDataWidget(text: 'No hay direcciones'),
                );
              }
            }
            else {
              return Center(
                child: NoDataWidget(text: 'No hay direcciones'),
              );
            }
          }
      ),
    );
  }

  Widget _radioSelectorDireccion(FormaEntrega formaEntrega, int index) {
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
                    formaEntrega.descripcion ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(color: Colors.grey[400])
        ],
      ),
    );
  }

  Widget _textSelectFormaEntrega() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30),
      child: Text(
        'Elije como quieres recibir tu pedido',
        style: TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}