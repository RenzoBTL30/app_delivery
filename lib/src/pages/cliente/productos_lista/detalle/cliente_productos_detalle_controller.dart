import 'package:app_delivery/src/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClienteProductosDetalleController extends GetxController {
  
  List<Producto> selectedProductos = [];

  ClienteProductosDetalleController() {
    
  }

  void checkIfProductsWasAdded(Producto producto, var precio, var contador) {
    precio.value = producto.precio ?? 0.0;
     if (GetStorage().read('bolsa_compras') != null) {
      
      if (GetStorage().read('bolsa_compras') is List<Producto>) {
        selectedProductos = GetStorage().read('bolsa_compras');
      }
      else {
      // Obteniendo los productos almacenados en sesion (storage)
      selectedProductos = Producto.fromJsonList(GetStorage().read('bolsa_compras'));
      }

      int index = selectedProductos.indexWhere((p) => p.idProducto == producto?.idProducto);
      

      if (index != -1) { //El producto ya fue agregado
        contador.value = selectedProductos[index].cantidad ?? 0;
        precio.value = producto.precio! * contador.value;
        selectedProductos.forEach((p) {
          print('Producto: ${p.toJson()}');
        });
      }

      

    }
  }

  void agregarABolsa(Producto producto, var precio, var contador, context) {

    if (contador.value > 0) {
      // Valida si el producto ya fue agregado con getstorage a la sesion del equipo
      int index = selectedProductos.indexWhere((p) => p.idProducto == producto.idProducto);

      if (index == -1) { // No ha sido agregado
        if (producto.cantidad == null) {
          if (contador.value > 0) {
            producto.cantidad = contador.value;
          }
          else {
            producto.cantidad = 1;
          }
        }

        selectedProductos.add(producto);

      }
      else { // Ya ha sido agregado en storage
        selectedProductos[index].cantidad = contador.value;
      }

      GetStorage().write('bolsa_compras', selectedProductos);
      Fluttertoast.showToast(msg: 'Producto agregado');
      regresarPantallaAnterior(context);
    }
    else {
      Fluttertoast.showToast(msg: 'Debes agregar al menos 1 producto');
    }
    
  }

  void addItem(Producto producto, var precio, var contador) {
    contador.value = contador.value + 1;
    print('PRODUCTO AGREGADO: ${producto.toJson()}');
    precio.value = producto.precio! * contador.value;
  }

  void removeItem(Producto producto, var precio, var contador) {
    if (contador.value > 0) {
      contador.value = contador.value - 1;
      print('PRODUCTO AGREGADO: ${producto.toJson()}');
      precio.value = producto.precio! * contador.value;
    }
  }

  void regresarPantallaAnterior(BuildContext context) {
    Navigator.pop(context);
  }

}