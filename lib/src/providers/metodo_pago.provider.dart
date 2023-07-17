import 'package:app_delivery/src/environment/environment.dart';
import 'package:app_delivery/src/models/lugar.dart';
import 'package:app_delivery/src/models/metodo_pago.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';

class MetodoPagoProvider extends GetConnect {
  String get url => Environment.API_URL + 'api/metodopago'; //El get es para que se actualicé el API_URL cuando se cambia en el environment.dart

  Future<List<MetodoPago>> getMetodosPago() async {
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

    List<MetodoPago> metodos = MetodoPago.fromJsonList(response.body);
    
    return metodos;
  }
}