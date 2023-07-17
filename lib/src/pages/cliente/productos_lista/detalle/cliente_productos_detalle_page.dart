import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/pages/cliente/productos_lista/detalle/cliente_productos_detalle_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteProductosDetallePage extends StatelessWidget {

  Producto producto = Producto();
  late ClienteProductosDetalleController con;
  var contador = 1.obs;
  var precio = 0.0.obs;

  ClienteProductosDetallePage({required this.producto}) {
    con = Get.put(ClienteProductosDetalleController());
  }

  @override
  Widget build(BuildContext context) {
    con.checkIfProductsWasAdded(producto, precio, contador);
    return Obx(() => Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        child: _botonesAgregarABolsa(context),
      ),
      body: Column(
        children: [
          _image(context),
          _textNombreProducto(),
          //_textPrecioProducto(),
          Row(
            children: [
              _textDescripcionProducto(),
            ],
          ),
        ],
      )
    ));
  }

  Widget _image(BuildContext context){
    return SafeArea(
      child: Stack(
        children: [
          FadeInImage(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage('assets/images/no-image.png'), 
            image: producto.imagen != null
                  ? NetworkImage(producto.imagen!)
                  : AssetImage('assets/images/no-image.png') as ImageProvider
          )
        ],
      )
    );
  }

  Widget _textNombreProducto() {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(top: 30, left: 30, right: 30),
    child: Row(
      children: [
        Expanded(
          child: AutoSizeText(
            producto.nombre ?? '',
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
            minFontSize: 22, // Tamaño mínimo de fuente permitido
            stepGranularity: 2, // Incremento de ajuste de fuente
            overflow: TextOverflow.ellipsis, // Mostrar puntos suspensivos si el texto desborda
          ),
        ),
        SizedBox(width: 10),
        Text(
          'S/${producto.precio?.toStringAsFixed(2).toString() ?? ''}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.red,
          ),
        ),
      ],
    ),
  );
}

  Widget _textDescripcionProducto() {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 15, left: 30, right: 30),
        child: Text(
          producto.descripcion ?? '',
          style: TextStyle(
            fontSize: 16,
          ),
        )
      ),
    );
  }

  /*Widget _textPrecioProducto() {
    return Flexible(
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 30),
        child: Text(
          'S/${producto.precio?.toStringAsFixed(2).toString() ?? ''}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.red,
          ),
        ),
      ),
    );
  }*/

  Widget _botonesAgregarABolsa(context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[400]),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 25),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => con.removeItem(producto, precio, contador), 
                child: Text(
                  '-',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(45, 37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25)
                    )
                  )
                ),
              ),

              ElevatedButton(
                onPressed: () {}, 
                child: Text(
                  '${contador.value}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(40, 37)
                ),
              ),

              ElevatedButton(
                onPressed: () => con.addItem(producto, precio, contador), 
                child: Text(
                  '+',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(45, 37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25)
                    )
                  )
                ),
              ),
              Spacer(), //ocupa el espacio entre los dos elevatedbutton y envia el segundo al extremo derecho
              ElevatedButton(
                onPressed: () => con.agregarABolsa(producto, precio, contador, context), 
                child: Text(
                  'Agregar S/${precio.value.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  )
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}