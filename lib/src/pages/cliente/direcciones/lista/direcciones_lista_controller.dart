import 'package:app_delivery/src/models/direccion.dart';
import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/providers/direccion.provider.dart';
import 'package:app_delivery/src/providers/orden.provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClienteDireccionesListaController extends GetxController {

  List<Direccion> direccion = [];
  DireccionProvider direccionProvider = DireccionProvider();
  OrdenProvider ordenProvider = OrdenProvider();
  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {});

  var radioValue = 0.obs;

  ClienteDireccionesListaController() {
    print('LA DIRECCION DE SESION ${GetStorage().read('direccion')}');
    radioValue.value = -1;
  }

  Future<List<Direccion>> getDireccion() async {
    direccion = await direccionProvider.findByUser(usuario.idUsuario ?? '');
    
    Direccion d = Direccion.fromJson(GetStorage().read('direccion') ?? {}) ; // DIRECCION SELECCIONADA POR EL USUARIO
    int index = direccion.indexWhere((ad) => ad.idDireccion == d.idDireccion);

    if (index != -1) { // LA DIRECCION DE SESION COINCIDE CON UN DATOS DE LA LISTA DE DIRECCIONES
      radioValue.value = index;
    }

    return direccion;
  }

  void handleRadioValueChange(int? value) {
    radioValue.value = value!;
    print('VALOR SELECCIONADO ${value}');
    GetStorage().write('direccion', direccion[value].toJson());
    update();
  }

  void goToAddressCreate() {
    Get.toNamed('/cliente/direccion/create');
  }

  void goToMetodoPago() {
    if (isValidDireccion()) {
      Get.toNamed('/cliente/pagos');
    }
  }

  bool isValidDireccion() {
    if (radioValue.value == -1){
      Get.snackbar('Error', 'Debes seleccionar una direccion');
      return false;
    }
    return true;
  }

}