import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/pages/admin/ordenes/detalle/admin_orden_detalle_controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:app_delivery/src/utils/relative_time_util.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:intl/intl.dart';

class AdminOrdenDetallePage extends StatelessWidget {

  AdminOrdenDetalleController con = Get.put(AdminOrdenDetalleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        height: con.orden.estado == '2' && con.orden.formaEntrega == 'Recojo en tienda'
            ? MediaQuery.of(context).size.height * 0.15
            : MediaQuery.of(context).size.height * 0,
        // padding: EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _btnMarcarEntregado(context),
          ],
        )
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Orden #${con.index+1}',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: con.orden.productos!.isNotEmpty ?
      SingleChildScrollView(
        child: Column(
           children: [
            SizedBox(height: 15),
            _titleDetalle(),
            SizedBox(height: 15),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: con.orden.productos!.map((Producto producto) {
                return _cardProducto(producto);
              }).toList(),
            ),
            SizedBox(height: 20),
            con.orden.estado == '1' 
            ? _btnTiempoEntrega(context, con.orden.idOrden ?? '')
            : _boxTiempoEntrega(context),
            SizedBox(height: 20),
            _boxDatos()
          ]
        ),
      )
      
      : Center(
          child: NoDataWidget(text: 'No hay ningun producto agregado aun')
      ),
    );
  }

/*
  Widget _boxTiempoEntrega(BuildContext context) {
    /*return Container(
      color: Color.fromRGBO(245, 245, 245, 1),
      child: Column(
        children: [
          _btnTiempoEntrega(context)
        ],
      ),
    );*/
    return Container(
      //width: MediaQuery.of(context).size.width * 0.8,
      //height: MediaQuery.of(context).size.height * 0.13,
      margin: EdgeInsets.only(
        left: 25, right: 25
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
          _btnTiempoEntrega(context)
        ],
      )
    );
  }
  */

  Widget _boxDatos() {
    return Container(
      color: Color.fromRGBO(245, 245, 245, 1),
      child: Column(
        children: [
          SizedBox(height: 20),
          _dataSubtotal(),
          SizedBox(height: 10),
          con.orden.formaEntrega == 'Delivery' ? _dataComisionDelivery() : Container(),
          con.orden.formaEntrega == 'Delivery' ? SizedBox(height: 10) : Container(),
          _dataTotal(),
          SizedBox(height: 20),
          Divider(
            height: 1,
            color: Colors.grey[600],
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10),
          _dataDate(),
          //_dataPuntosCanjeados
          _dataFormaEntrega(),
          con.orden.formaEntrega == 'Delivery' ? _dataDireccion() : Container(),
          con.orden.formaEntrega == 'Delivery' ? _dataLugar() : Container(),
          _dataMetodoPago(),
          _dataEstadoOrden(),
        ],
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

  Widget _dataLugar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text('Lugar'),
        subtitle: Text('${con.orden.direccion?.lugar ?? ''}'),
        trailing: Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataFormaEntrega() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text('Forma de entrega'),
        subtitle: Text('${con.orden.formaEntrega ?? ''}'),
        trailing: Icon(Icons.delivery_dining),
      ),
    );
  }

  Widget _dataMetodoPago() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text('Método de pago'),
        subtitle: Text('${con.orden.metodoPago ?? ''}'),
        trailing: Icon(Icons.paid),
      ),
    );
  }

  Widget _dataEstadoOrden() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text('Estado'),
        subtitle: Text(
          '${con.orden.estado == '1' ? 'Pendiente' : 
             con.orden.estado == '2' ? 'Preparado' :
             con.orden.estado == '3' ? 'Entregado' : '' ?? ''}'),
        trailing: Icon(Icons.fact_check),
      ),
    );
  }

  Widget _dataDireccion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text('Direccion de entrega'),
        subtitle: Text(con.orden.direccion?.direccion ?? ''),
        trailing: Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate() {

    DateTime fechahora = DateTime.parse(con.orden.fechaOrden ?? '');
    fechahora = fechahora.subtract(Duration(hours: 5));

    var fechaFormateada = DateFormat("yyyy-MM-dd HH:mm").format(fechahora).toString().split('.')[0];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text('Fecha del pedido'),
        //con.orden.fecha ?? 0) 
        subtitle: Text('${fechaFormateada}'),
        trailing: Icon(Icons.timer),
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
            'S/${con.orden.subtotal!.toStringAsFixed(2).toString()}',
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
          'Delivery:',
            style: TextStyle(
              fontSize: 16
            ),
        ),
        Spacer(),
        Text(
          'S/${con.orden.direccion!.comision!.toStringAsFixed(2).toString()}',
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
            'S/${con.orden.total!.toStringAsFixed(2).toString()}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    );
  }

  Widget _cardProducto(Producto producto) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      child: Row(
        children: [
          _imagenProducto(producto),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                producto.nombre ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Cantidad: ${producto.cantidad} - Precio: S/${(producto.precio! * producto.cantidad!).toStringAsFixed(2).toString()}',
                style: TextStyle(
                    // fontWeight: FontWeight.bold
                  fontSize: 13
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imagenProducto(Producto producto) {
    return Container(
      height: 50,
      width: 50,
      // padding: EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          image: producto.imagen != null
              ? NetworkImage(producto.imagen!)
              : AssetImage('assets/images/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder:  AssetImage('assets/images/no-image.png'),
        ),
      ),
    );
  }

  Widget _btnMarcarEntregado(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              con.orden.estado == '2' && con.orden.formaEntrega == 'Recojo en tienda'
              ? Container(
                child: ElevatedButton(
                    onPressed: () => con.updateOrder(),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        backgroundColor: Color(0xFFC42227)
                    ),
                    child: Text(
                      'Marcar como Entregado',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    )
                ),
              )
              : Container()
            ],
          ),
        )

      ],
    );
  }

  Widget _btnTiempoEntrega(BuildContext context, String idOrden) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                child: ElevatedButton(
                    onPressed: () => con.openBottomSheet(context, idOrden),
                    style: ElevatedButton.styleFrom(
                        //padding: EdgeInsets.all(15),
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                        backgroundColor: Color(0xFFC42227)
                    ),
                    child: Text(
                      'Tiempo de entrega: ${con.orden.tiempoEntrega ?? '-'}',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    )
                ),
              )
            ],
          ),
        )

      ],
    );
  }

  Widget _boxTiempoEntrega(BuildContext context) {
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
          SizedBox(height: 10),
          _dataTiempoEntrega(),
          SizedBox(height: 10)
        ],
      )
    );
  }

  Widget _dataTiempoEntrega() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tiempo de entrega:',
            style: TextStyle(
              fontSize: 16
            ),
          ),
          SizedBox(width: 5),
          Text(
            '${con.orden.tiempoEntrega}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red
            ),
          )
        ],
      )
    );
  }
}
