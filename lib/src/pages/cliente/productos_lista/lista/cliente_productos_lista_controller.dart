import 'package:app_delivery/src/models/categoria.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/pages/cliente/productos_lista/detalle/cliente_productos_detalle_page.dart';
import 'package:app_delivery/src/providers/categoria.provider.dart';
import 'package:app_delivery/src/providers/producto.provider.dart';
import 'package:flutter/material.dart';
//import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:get/get.dart';

class ClienteProductosListaController extends GetxController {
  
  CategoriaProvider categoriaProvider = CategoriaProvider();
  ProductoProvider productoProvider = ProductoProvider();

  List<Categoria> categorias = <Categoria>[].obs;
  
  ClienteProductosListaController() {
    getCategorias();
  }

  void getCategorias() async {
    var result = await categoriaProvider.listar();
    categorias.clear();
    categorias.addAll(result);
  }

  Future<List<Producto>> getProductos(String idCategoria) async {
    return await productoProvider.findByCategoria(idCategoria);
  }

  void goToOrdenesCreate() {
    Get.toNamed('/cliente/ordenes/create');
  }

  void openBottomSheet(BuildContext context,Producto producto) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ClienteProductosDetallePage(producto: producto)
    );

    /* Otra opción con el paquete de modal_bottom_sheet 
    que actualmente no tiene una versión estable para flutter v3.10 (revisar la documentación del paquete) 
    pero funciona con la versión preliminar ^3.0.0-pre del paquete
    
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClienteProductosDetallePage()
      );

    */


  }

}