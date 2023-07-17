import 'package:app_delivery/src/environment/environment.dart';
import 'package:get/get.dart';

class RolProvider extends GetConnect {
  String get url => Environment.API_URL + 'api/rol'; //El get es para que se actualicé el API_URL cuando se cambia en el environment.dart

  Future<Response> asignarRol(idUsuario, idRol) async {
    
    Response response = await post(
      '${url}/asignar/${idUsuario}',
      {'id_rol': idRol},
      headers: { 
        'Content-Type': 'application/json'
      }
    );

    return response;
  }
}