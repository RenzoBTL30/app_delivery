import 'package:app_delivery/src/environment/environment.dart';
import 'package:app_delivery/src/models/orden.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrdenProvider extends GetConnect {

  String url = Environment.API_URL + 'api/orden';

  Usuario usuarioSession = Usuario.fromJson(GetStorage().read('usuario') ?? {});

  Future<List<Orden>> findByStatus(String estado) async {
    Response response = await get(
        '$url/buscar/porestado/$estado',
        headers: {
          'Content-Type': 'application/json',
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    //print(response.statusCode);

    List<Orden> ordenes = Orden.fromJsonList(response.body);
    //print(ordenes);

    return ordenes;
  }


  Future<List<Orden>> findByStatusToDelivery(String estado) async {
    Response response = await get(
        '$url/buscar/porestadotodelivery/$estado',
        headers: {
          'Content-Type': 'application/json',
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    //print(response.statusCode);

    List<Orden> ordenes = Orden.fromJsonList(response.body);
    //print(ordenes);

    return ordenes;
  }



  Future<List<Orden>> findByClienteRecojoAndStatus(String id_usuario, String estado) async {
    Response response = await get(
        '$url/buscar/porclienterecojoestado/$id_usuario/$estado',
        headers: {
          'Content-Type': 'application/json',
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Orden> ordenes = Orden.fromJsonList(response.body);

    return ordenes;
  }


  Future<List<Orden>> findByClienteDeliveryAndStatus(String id_usuario, String estado) async {
    Response response = await get(
        '$url/buscar/porclientedeliveryestado/$id_usuario/$estado',
        headers: {
          'Content-Type': 'application/json',
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Orden> ordenes = Orden.fromJsonList(response.body);

    return ordenes;
  }

  /*
  Future<List<Order>> findByClientAndStatus(String idClient, String status) async {
    Response response = await get(
        '$url/findByClientAndStatus/$idClient/$status',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene permitido leer esta informacion');
      return [];
    }

    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }
  */

  Future<ResponseApi> create(Orden orden) async {
    Response response = await post(
        '$url/crear',
        orden.toJson(),
        headers: {
          'Content-Type': 'application/json',
        }
    ); // ESPERAR HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }


  Future<ResponseApi> actualizarToDespachado(Orden orden, String estado) async {
    Response response = await put(
        '$url/update/estado/${orden.idOrden}',
        { 'estado': estado},
        headers: {
          'Content-Type': 'application/json',
        }
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> actualizarToEntregado(Orden orden, String estado) async {
    Response response = await put(
        '$url/update/estado/${orden.idOrden}',
        { 'estado': estado},
        headers: {
          'Content-Type': 'application/json',
        }
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }


  Future<ResponseApi> insertTiempoEntrega(String id_orden, String tiempoEntrega) async {
    Response response = await put(
        '$url/inserttiempo/${id_orden}',
        { 'tiempo_entrega': tiempoEntrega},
        headers: {
          'Content-Type': 'application/json',
        }
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> cancelarOrden(String idOrden) async {
    Response response = await put(
        '$url/cancelarorden/${idOrden}',{},
        headers: {
          'Content-Type': 'application/json',
        }
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

}