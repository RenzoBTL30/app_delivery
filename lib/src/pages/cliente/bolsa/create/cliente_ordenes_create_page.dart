import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/pages/cliente/bolsa/create/cliente_ordenes_create_controller.dart';
import 'package:app_delivery/src/widgets/no_data_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteOrdenesCreatePage extends StatelessWidget {

  ClienteOrdenesCreateController con = Get.put(ClienteOrdenesCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        height: 100,
        child: _totalAPagar(context),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Bolsa',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: con.selectedProductos.length > 0
            ? ListView(
              children: con.selectedProductos.map((Producto producto){
                return _cardProducto(producto);
              }).toList(),
            )
            : NoDataWidget(text: 'No hay ningún producto agregado')
    ));
  }

  Widget _totalAPagar(BuildContext context){
    return Column(
      children: [
        Divider(height: 1,color: Colors.grey[400],),
        Container(
          margin: EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total: S/${con.total.value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => con.goToFormaEntregas(),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    backgroundColor: Color(0xFFC42227)
                  ),
                  child: Text(
                    'Confirmar Orden',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                )
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardProducto(Producto producto) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      children: [
        _imageProducto(producto),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  producto.nombre ?? '', 
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 7),
              _botonesAddOrRemove(producto),
            ],
          ),
        ),
        SizedBox(width: 5),
        Column(
          children: [
            _textPrecio(producto),
            _iconEliminar(producto),
          ],
        ),
      ],
    ),
  );
}
  Widget _iconEliminar(Producto producto) {
    return IconButton(
      onPressed: () => con.deleteItem(producto), 
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      )
    );
  }

  Widget _textPrecio(Producto producto) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'S/${(producto.precio! * producto.cantidad!).toStringAsFixed(2)}',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _imageProducto(Producto producto) {
    return Container(
      height: 70,
      width: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: FadeInImage(
          image: producto.imagen != null 
          ? NetworkImage(producto.imagen!) 
          : AssetImage('assets/images/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 50),
          placeholder: AssetImage('assets/images/no-image.png'),
        ),
      )       
    );
  }

  Widget _botonesAddOrRemove(Producto producto) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => con.removeItem(producto),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8)
              )
            ),
            child: Text('-'),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.grey[200],
          child: Text('${producto.cantidad ?? 0}'),
        ),
        GestureDetector(
          onTap: () => con.addItem(producto),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8)
              )
            ),
            child: Text('+'),
          ),
        ),
      ],
    );
  }
}