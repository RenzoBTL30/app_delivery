import 'package:app_delivery/src/models/direccion.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/lista/direcciones_lista_controller.dart';
import 'package:app_delivery/src/pages/cliente/direcciones_solo_lista/lista/direcciones_solo_lista_lista_controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteDireccionesSoloListaListaPage extends StatelessWidget {

  ClienteDireccionesSoloListaListaController con = Get.put(ClienteDireccionesSoloListaListaController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
          'Mis Direcciones',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        actions: [
          _iconDireccionCreate()
        ],
      ),
      body: GetBuilder<ClienteDireccionesSoloListaListaController> ( builder: (value) => Stack(
        children: [
          _textSelectDireccion(),
          _listDireccion(context)
        ],
      )),
    );
  }

  Widget _listDireccion(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: FutureBuilder(
          future: con.getDireccion(),
          builder: (context, AsyncSnapshot<List<Direccion>> snapshot) {
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

  Widget _radioSelectorDireccion(Direccion direccion, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_pin),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    direccion.direccion ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    direccion.lugar ?? '',
                    style: TextStyle(
                        fontSize: 12
                    ),
                  )
                ],
              )
            ],
          ),
          Divider(color: Colors.grey[400])
        ],
      ),
    );
  }

  Widget _textSelectDireccion() {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 30),
      child: Text(
        'Direcciones creadas',
        style: TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _iconDireccionCreate() {
    return IconButton(
        onPressed: () => con.goToAddressCreate(),
        icon: Icon(
          Icons.add,
          color: Colors.black,
        )
    );
  }
}
