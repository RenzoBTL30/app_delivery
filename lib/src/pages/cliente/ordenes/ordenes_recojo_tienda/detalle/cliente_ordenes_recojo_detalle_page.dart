import 'package:app_delivery/src/pages/cliente/ordenes/ordenes_recojo_tienda/detalle/cliente_ordenes_recojo_detalle_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/utils/relative_time_util.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:intl/intl.dart';

class ClienteOrdenesRecojoDetallePage extends StatelessWidget {

  ClienteOrdenesRecojoDetalleController con = Get.put(ClienteOrdenesRecojoDetalleController());

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      bottomNavigationBar: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        height:MediaQuery.of(context).size.height * 0.60,
        // padding: EdgeInsets.only(top: 5),
        child: ListView(
        children: [
          SizedBox(height: 20),
          _dataSubtotal(),
          SizedBox(height: 10),
          _dataComisionDelivery(),
          SizedBox(height: 10),
          _dataTotal(),
          SizedBox(height: 20),
          _dataDate(),
          //_dataPuntosCanjeados
          _dataFormaEntrega(),
          _dataDireccion(),
          _dataLugar(),
          _dataMetodoPago(),
          _dataEstadoOrden(),
        ],
      ),
      ),
      */
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
            _boxDatos()
          ]
        ),
      )
      
      : Center(
          child: NoDataWidget(text: 'No hay ningun producto agregado aun')
      ),
    );
  }

  Widget _boxDatos() {
    return Container(
      color: Color.fromRGBO(245, 245, 245, 1),
      child: Column(
        children: [
          SizedBox(height: 20),
          _dataSubtotal(),
          SizedBox(height: 10),
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
}