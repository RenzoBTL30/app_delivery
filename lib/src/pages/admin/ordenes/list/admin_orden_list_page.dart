import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/pages/admin/ordenes/list/admin_orden_list_controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:app_delivery/src/utils/relative_time_util.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/standalone.dart';

class AdminOrdenListPage extends StatelessWidget {

  AdminOrdenListController con = Get.put(AdminOrdenListController());

  @override
  Widget build(BuildContext context) {

    return Obx(() => DefaultTabController(
      length: con.estados.length,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              centerTitle: true,
              title: const Text(
                'Pedidos',
                style: TextStyle(color: Colors.black),
              ),
              iconTheme: IconThemeData(
                color: Colors.black
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[600],
                tabs: List<Widget>.generate(con.estados.length, (index) {
                  return Tab(
                    child: Text(
                      con.estados[index] == '1' ? 'Pendiente': 
                      con.estados[index] == '2' ? 'Preparado' :
                      con.estados[index] == '3' ? 'Entregado' : ''
                    ),
                  );
                }),
              ),
            ),
          ),
          body: TabBarView(
            children: con.estados.map((String estado) {
              return FutureBuilder(
                  future: con.getOrdenes(estado),
                  builder: (context, AsyncSnapshot<List<Orden>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardOrden(snapshot.data![index],index);
                            }
                        );
                      }
                      else {
                        return Center(child: NoDataWidget(text: 'No hay ordenes'));
                      }
                    }
                    else {
                      return Center(child: NoDataWidget(text: 'No hay ordenes'));
                    }
                  }
              );
            }).toList(),
          )
      ),
    ));
  }

  Widget _cardOrden(Orden orden, int index) {


    DateTime fechahora = DateTime.parse(orden.fechaOrden ?? '');
    fechahora = fechahora.subtract(Duration(hours: 5));

    var fechaFormateada = DateFormat("yyyy-MM-dd HH:mm").format(fechahora).toString().split('.')[0];

    return GestureDetector(
      onTap: () => con.goToOrdenDetalle(orden, index),
      child: Container(
        height: 150,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFA50104),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'Orden #${index+1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text('Fecha del Pedido: ${fechaFormateada}')
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text('Cliente: ${orden.cliente?.nombre ?? ''} ${orden.cliente?.apellidos ?? ''}'),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text('Forma de entrega: ${orden.formaEntrega ?? ''}'),
                    ),
                    
                    /*orden.formaEntrega == 'Delivery'
                    ? Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text('Entregar en: ${orden.direccion?.direccion ?? ''}'),
                    ) 
                    : Container(),
                    */

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
