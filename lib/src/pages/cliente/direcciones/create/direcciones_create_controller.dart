import 'package:app_delivery/src/models/direccion.dart';
import 'package:app_delivery/src/models/lugar.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/lista/direcciones_lista_controller.dart';
import 'package:app_delivery/src/pages/cliente/direcciones/map/direcciones_map_page.dart';
import 'package:app_delivery/src/providers/direccion.provider.dart';
import 'package:app_delivery/src/providers/lugar.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ClienteDireccionesCreateController extends GetxController {

  TextEditingController direccionController = TextEditingController();
  TextEditingController lugarController = TextEditingController();
  TextEditingController puntoReferenciaController = TextEditingController();

  double latRefPoint = 0;
  double lngRefPoint = 0;

  Usuario usuario = Usuario.fromJson(GetStorage().read('usuario') ?? {});

  var idLugar = ''.obs;
  DireccionProvider direccionProvider = DireccionProvider();
  LugarProvider lugarProvider = LugarProvider();

  List<Lugar> lugares = <Lugar>[].obs;
  List<Direccion> direccionWithLugar = [];

  ClienteDireccionesListaController clienteDireccionesListaController = Get.find();

  ClienteDireccionesCreateController() {
    getLugares();
  }

  void getLugares() async {
    var result = await lugarProvider.getLugares();
    lugares.clear();
    lugares.addAll(result);
  }

  void openGoogleMaps(BuildContext context) async {
    Map<String, dynamic> refPointMap = await showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClienteDireccionesMapPage(),
        isDismissible: false,
        enableDrag: false
    );

    print('REF POINT MAP ${refPointMap}');
    puntoReferenciaController.text = refPointMap['direccion'];
    latRefPoint = refPointMap['lat'];
    lngRefPoint = refPointMap['lng'];
  }

  void createAddress() async {
    String direccionNombre = direccionController.text;

    if (isValidForm(direccionNombre)) {
      Direccion direccion = Direccion(
        direccion: direccionNombre,
        idLugar: idLugar.value,
        lat: latRefPoint,
        lng: lngRefPoint,
        idUsuario: usuario.idUsuario
      );

      ResponseApi responseApi = await direccionProvider.create(direccion);
      Fluttertoast.showToast(msg: 'La dirección ha sido creada correctamente', toastLength: Toast.LENGTH_LONG);

      if (responseApi.success == true) {
        var indexLugar = lugares.indexWhere((element) => element.idLugar == direccion.idLugar);

        direccion.idDireccion = responseApi.data.toString();

        direccion.lugar = lugares[indexLugar].lugar;
        direccion.comision = lugares[indexLugar].comision;

        
        GetStorage().write('direccion', direccion.toJson());

        clienteDireccionesListaController.update();

        Get.back();
      }

    }
  }

  bool isValidForm(String address) {
    if (address.isEmpty){
      Get.snackbar('Formulario no valido', 'Ingresa el nombre de la direccion');
      return false;
    }
    if (idLugar.value == ''){
      Get.snackbar('Formulario no valido', 'Ingresa el lugar');
      return false;
    }
    if (latRefPoint == 0){
      Get.snackbar('Formulario no valido', 'Selecciona el punto de referencia');
      return false;
    }
    if (lngRefPoint == 0){
      Get.snackbar('Formulario no valido', 'Selecciona el punto de referencia');
      return false;
    }

    return true;
  }

}