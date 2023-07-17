import 'package:app_delivery/src/models/producto.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClienteOrdenesCreateController extends GetxController {
  
  List<Producto> selectedProductos = <Producto>[].obs;
  var total = 0.0.obs;

  ClienteOrdenesCreateController () {
    if (GetStorage().read('bolsa_compras') != null) {
      if (GetStorage().read('bolsa_compras') is List<Producto>) {
        var result = GetStorage().read('bolsa_compras');
        selectedProductos.clear();
        selectedProductos.addAll(result);
      }
      else {
        // Obteniendo los productos almacenados en sesion (storage)
        var result = Producto.fromJsonList(GetStorage().read('bolsa_compras'));
        selectedProductos.clear();
        selectedProductos.addAll(result);
      }
      calcularTotal();
    }
  }

  void calcularTotal() {
    total.value = 0.0;
    selectedProductos.forEach((p) { 
      total.value = total.value + (p.cantidad! * p.precio!);
    });
  }

  void deleteItem(Producto producto){
    selectedProductos.remove(producto);
    GetStorage().write('bolsa_compras', selectedProductos);
    calcularTotal();
  }

  void addItem(Producto producto) {
    int index = selectedProductos.indexWhere((p) => p.idProducto == producto.idProducto);
    selectedProductos.remove(producto);
    producto.cantidad = producto.cantidad! + 1;
    selectedProductos.insert(index, producto);
    GetStorage().write('bolsa_compras', selectedProductos);
    calcularTotal();
  }

  void removeItem(Producto producto) {
    if (producto.cantidad! > 1) {
      int index = selectedProductos.indexWhere((p) => p.idProducto == producto.idProducto);
      selectedProductos.remove(producto);
      producto.cantidad = producto.cantidad! - 1;
      selectedProductos.insert(index, producto);
      GetStorage().write('bolsa_compras', selectedProductos);
      calcularTotal();
    }
    
  }

  void goToFormaEntregas() {
    if (isValidBolsa()) {
      Get.toNamed('/cliente/formaentrega');
    }
  }

  bool isValidBolsa() {
    if (selectedProductos.isEmpty){
      Get.snackbar('Error', 'Debes agregar al menos 1 producto');
      return false;
    }
    return true;
  }

}