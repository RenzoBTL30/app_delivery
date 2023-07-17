import 'package:app_delivery/src/environment/environment.dart';
import 'package:app_delivery/src/models/forma_entrega.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';

class FormaEntregaProvider extends GetConnect {
  String get url => Environment.API_URL + 'api/formaentrega'; //El get es para que se actualicé el API_URL cuando se cambia en el environment.dart

  Future<List<FormaEntrega>> getFormasEntrega() async {
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

    List<FormaEntrega> formas = FormaEntrega.fromJsonList(response.body);
    
    return formas;
  }
}