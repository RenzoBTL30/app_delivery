//import 'package:app_delivery/src/environment/url.node.dart';
import 'package:app_delivery/src/environment/environment.dart';
import 'package:app_delivery/src/models/categoria.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';

class CategoriaProvider extends GetConnect {
  String get url => Environment.API_URL + 'api/categoria'; //El get es para que se actualicé el API_URL cuando se cambia en el environment.dart

  Future<List<Categoria>> listar() async {
    Response response = await get(
      '${url}/listar',
      headers: { 
        'Content-Type': 'application/json'
      }
    );

    if (response.statusCode == 401) {
      Get.snackbar('Petición denegada', 'Tu usuario no tiene permitido leer esta información');
      return [];
    }

    List<Categoria> categorias = Categoria.fromJsonList(response.body);
    
    return categorias;
  }


  Future<ResponseApi> create(Categoria categoria) async {
    Response response = await post(
      '${url}/crear',
      categoria.toJson(),
      headers: { 
        'Content-Type': 'application/json'
      }
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
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
}