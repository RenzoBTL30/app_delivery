//import 'package:app_delivery/src/environment/url.node.dart';
import 'dart:convert';
import 'dart:io';

import 'package:app_delivery/src/environment/environment.dart';
import 'package:app_delivery/src/models/categoria.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/usuario.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class ProductoProvider extends GetConnect {
  String get url => Environment.API_URL + 'api/producto'; //El get es para que se actualicé el API_URL cuando se cambia en el environment.dart

  Future<Response> listar() async {
    Response response = await get(
      '${url}/listar',
      headers: { 
        'Content-Type': 'application/json'
      }
    );
    return response.body;
  }
  

   Future<List<Producto>> findByCategoria(String idCategoria) async {
    Response response = await get(
      '${url}/buscar/productos/${idCategoria}',
      headers: { 
        'Content-Type': 'application/json'
      }
    );

    if (response.statusCode == 401) {
      Get.snackbar('Petición denegada', 'Tu usuario no tiene permitido leer esta información');
      return [];
    }

    List<Producto> productos = Producto.fromJsonList(response.body);
    
    return productos;
  }


  Future<Stream> create(Producto producto, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD,'/api/producto/crear');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path)
    ));
    request.fields['producto'] = json.encode(producto);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }


}