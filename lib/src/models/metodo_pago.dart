import 'dart:convert';

MetodoPago metodoPagoFromJson(String str) => MetodoPago.fromJson(json.decode(str));

String metodoPagoToJson(MetodoPago data) => json.encode(data.toJson());

class MetodoPago {
    String? idMetodoPago;
    String? nombre;

    MetodoPago({
        this.idMetodoPago,
        this.nombre,
    });

    factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
        idMetodoPago: json["id_metodo_pago"],
        nombre: json["nombre"],
    );

    static List<MetodoPago> fromJsonList(List<dynamic> jsonList) {
      List<MetodoPago> toList = [];
      jsonList.forEach((item) { 
        MetodoPago metodoPago = MetodoPago.fromJson(item);
        toList.add(metodoPago);
      });
      return toList;
    }

    Map<String, dynamic> toJson() => {
        "id_metodo_pago": idMetodoPago,
        "nombre": nombre,
    };
}