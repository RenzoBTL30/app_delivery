import 'package:app_delivery/src/models/forma_entrega.dart';
import 'package:app_delivery/src/models/lugar.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/pages/cliente/forma_entrega/cliente_forma_entrega_controller.dart';
import 'package:app_delivery/src/pages/cliente/resumen_pago/resumen_pago_controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteResumenPagoPage extends StatelessWidget {

  ClienteResumenPagoController con = Get.put(ClienteResumenPagoController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           _buttonNext(context),
           SizedBox(height: 30),
           _buttonCancelar(context),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(
          'Resumen del pago',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      /*body: GetBuilder<ClientePagosController> ( builder: (value) => Column(
        children: [
          Expanded(
            child: ListView(
              children: con.productos.map((Producto producto) {
                return _cardProducto(producto);
              }).toList(),
            ),
          ),
          _boxData(),
          _titleMetodoPago(),
          Expanded(child: _listMetodoPago(context)),
           _textFieldBilletePago(),
        ],
      )),*/
      body: GetBuilder<ClienteResumenPagoController>(
        builder: (value) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              _titleDetalle(),
              SizedBox(height: 15),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: con.productos.map((Producto producto) {
                  return _cardProducto(producto);
                }).toList(),
              ),
              SizedBox(height: 20),
              _boxData(context),
              SizedBox(height: 25),
              _boxData2(context),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonNext(BuildContext context) {
    return Container(
      width: 180,
      height: 50,
      child: ElevatedButton(
        onPressed: () => con.createOrden(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFC42227),
        ),
        child: const Text(
          'Finalizar Pedido',
          style: TextStyle(color: Colors.white, fontSize: 17),
          textAlign: TextAlign.center,
        )
      ),
    );
  }


  Widget _buttonCancelar(BuildContext context) {
    return Container(
      width: 180,
      height: 50,
      child: ElevatedButton(
        onPressed: () => con.mostrarDialogoCancel(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFC42227)
        ),
        child: const Text(
          'Cancelar pedido',
          style: TextStyle(color: Colors.white, fontSize: 17),
          textAlign: TextAlign.center,
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


  Widget _boxData2(BuildContext context) {
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
          _dataCliente(),
          _dataFormaEntrega(),
          con.f.idFormaEntrega == '2' ? _dataDireccion() :
          con.f.idFormaEntrega == '1' ? Container() : Container(),
          con.f.idFormaEntrega == '2' ? _dataLugar() :
          con.f.idFormaEntrega == '1' ? Container() : Container(),
          _dataMetodoPago(),
          con.billetePago == '' || con.m.nombre != 'En efectivo' ? Container() : _dataBilletePago()
          
        ],
      )
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
          'Comisión Delivery:',
            style: TextStyle(
              fontSize: 16
            ),
        ),
        Spacer(),
        Text(
          'S/${con.d.comision!.toStringAsFixed(2).toString()}',
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


  Widget _dataCliente() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Cliente'),
        subtitle: Text('${con.usuario.nombre ?? ''} ${con.usuario.apellidos ?? ''}'),
        trailing: Icon(Icons.person),
      ),
    );
  }

  Widget _dataFormaEntrega() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Forma de entrega'),
        subtitle: Text('${con.f.descripcion ?? ''}'),
        trailing: Icon(Icons.delivery_dining),
      ),
    );
  }

  Widget _dataMetodoPago() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Método de pago'),
        subtitle: Text(con.m.nombre ?? ''),
        trailing: Icon(Icons.paid),
      ),
    );
  }

  Widget _dataBilletePago() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Billete de pago'),
        subtitle: Text(con.billetePago ?? ''),
        trailing: Icon(Icons.payment),
      ),
    );
  }

  Widget _dataDireccion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Direccion de entrega'),
        subtitle: Text(con.d.direccion ?? ''),
        trailing: Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataLugar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text('Lugar de entrega'),
        subtitle: Text(con.d.lugar ?? ''),
        trailing: Icon(Icons.location_on),
      ),
    );
  }
}