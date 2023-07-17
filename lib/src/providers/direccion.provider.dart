import 'package:app_delivery/src/environment/environment.dart';
import 'package:app_delivery/src/models/direccion.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DireccionProvider extends GetConnect {

  String url = Environment.API_URL + 'api/direccion';

  Usuario usuarioSession = Usuario.fromJson(GetStorage().read('usuario') ?? {});


  Future<List<Direccion>> findByUser(String idUsuario) async {
    Response response = await get(
        '$url/buscarPorUsuario/$idUsuario',
        headers: {
          'Content-Type': 'application/json',
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Direccion> direccion = Direccion.fromJsonList(response.body);

    return direccion;
  }


  Future<ResponseApi> create(Direccion direccion) async {
    Response response = await post(
        '$url/crear',
        direccion.toJson(),
        headers: {
          'Content-Type': 'application/json',
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

}