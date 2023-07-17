import 'dart:convert';

import 'package:app_delivery/src/models/direccion.dart';
import 'package:app_delivery/src/models/producto.dart';
import 'package:app_delivery/src/models/usuario.dart';

Orden orderFromJson(String str) => Orden.fromJson(json.decode(str));

String orderToJson(Orden data) => json.encode(data.toJson());

class Orden {

  String? idOrden;
  String? idUsuario;
  String? idDireccion;
  String? idMetodoPago;
  String? metodoPago;
  String? idFormaEntrega;
  String? formaEntrega;
  String? billetePago;
  String? tiempoEntrega;
  String? fechaOrden;
  double? subtotal;
  double? total;
  String? estado;
  List<Producto>? productos = [];
  Usuario? cliente;
  Direccion? direccion;

  Orden({
    this.idOrden,
    this.idUsuario,
    this.idDireccion,
    this.idMetodoPago,
    this.metodoPago,
    this.idFormaEntrega,
    this.formaEntrega,
    this.billetePago,
    this.tiempoEntrega,
    this.fechaOrden,
    this.subtotal,
    this.total,
    this.estado,
    this.productos,
    this.cliente,
    this.direccion,
  });

  factory Orden.fromJson(Map<String, dynamic> json) => Orden(
    idOrden: json["id_orden"],
    idUsuario: json["id_usuario"],
    idDireccion: json["id_direccion"],
    idMetodoPago: json["id_metodo_pago"],
    metodoPago: json["metodo_pago"],
    idFormaEntrega: json["id_forma_entrega"],
    formaEntrega: json["forma_entrega"],
    billetePago: json['billete_pago'],
    tiempoEntrega: json['tiempo_entrega'],
    fechaOrden: json["fecha_orden"],
    subtotal: json["subtotal"]?.toDouble(),
    total: json["total"]?.toDouble(),
    estado: json["estado"],
    productos: json["productos"] != null ? List<Producto>.from(json["productos"].map((model) => model is Producto ? model : Producto.fromJson(model))) ?? [] : [],
    cliente: json['cliente'] is String ? usuarioFromJson(json['cliente']) : json['cliente'] is Usuario ? json['cliente'] : Usuario.fromJson(json['cliente'] ?? {}),
    direccion: json['direccion'] is String ? direccionFromJson(json['direccion']) : json['direccion'] is Direccion ? json['direccion'] : Direccion.fromJson(json['direccion'] ?? {}),
  );

  static List<Orden> fromJsonList(List<dynamic> jsonList) {
    List<Orden> toList = [];

    jsonList.forEach((item) {
      Orden orden = Orden.fromJson(item);
      toList.add(orden);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id_orden": idOrden,
    "id_usuario": idUsuario,
    "id_direccion": idDireccion,
    "id_metodo_pago": idMetodoPago,
    "metodo_pago": metodoPago,
    "id_forma_entrega": idFormaEntrega,
    "forma_entrega": formaEntrega,
    "billete_pago": billetePago,
    "tiempo_entrega": tiempoEntrega,
    "fecha_orden": fechaOrden,
    "subtotal": subtotal,
    "total": total,
    "estado": estado,
    "productos": productos,
    "cliente": cliente,
    "direccion": direccion,
  };
}
