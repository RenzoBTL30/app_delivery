//import 'package:app_delivery/src/environment/url.node.dart';
import 'package:app_delivery/src/environment/environment.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';

class UsuarioProvider extends GetConnect {
  String get url => Environment.API_URL + 'api/usuario'; //El get es para que se actualicé el API_URL cuando se cambia en el environment.dart

  Future<Response> create(Usuario usuario) async {
    Response response = await post(
      '${url}/crear',
      usuario.toJson(),
      headers: { 
        'Content-Type': 'application/json'
      }
    );

    return response;
  }

  Future<ResponseApi> actualizar(Usuario usuario) async {
    Response response = await put(
      '${url}/actualizar/${usuario.idUsuario}',
      usuario.toJson(),
      headers: { 
        'Content-Type': 'application/json'
      }
    );

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la información');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> actualizarContra(Usuario usuario) async {
    Response response = await put(
      '${url}/actualizar/contra/${usuario.idUsuario}',
      usuario.toJson(),
      headers: { 
        'Content-Type': 'application/json'
      }
    );

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la contraseña');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }


  String get url_login => Environment.API_URL + 'api/auth';

  // Login de la app:
  Future<ResponseApi> login(String email, String contrasenia) async {
    Response response = await post(
      '${url_login}/login',
      {
        'email': email,
        'contrasenia': contrasenia
      },
      headers: { 
        'Content-Type': 'application/json'
      }
    );

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la petición');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}