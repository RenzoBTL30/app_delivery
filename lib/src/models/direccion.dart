import 'dart:convert';

Direccion direccionFromJson(String str) => Direccion.fromJson(json.decode(str));

String direccionToJson(Direccion data) => json.encode(data.toJson());

class Direccion {
    String? idDireccion;
    String? direccion;
    String? idLugar;
    String? lugar;
    double? comision;
    double? lat;
    double? lng;
    String? idUsuario;

    Direccion({
        this.idDireccion,
        this.direccion,
        this.idLugar,
        this.lugar,
        this.comision,
        this.lat,
        this.lng,
        this.idUsuario,
    });

    factory Direccion.fromJson(Map<String, dynamic> json) => Direccion(
        idDireccion: json["id_direccion"],
        direccion: json["direccion"],
        idLugar: json["id_lugar"],
        lugar: json["lugar"],
        comision: json["comision"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        idUsuario: json["id_usuario"],
    );

    static List<Direccion> fromJsonList(List<dynamic> jsonList) {
      List<Direccion> toList = [];

      jsonList.forEach((item) {
        Direccion direccion = Direccion.fromJson(item);
        toList.add(direccion);
      });

      return toList;
    }

    Map<String, dynamic> toJson() => {
        "id_direccion": idDireccion,
        "direccion": direccion,
        "id_lugar": idLugar,
        "lugar":lugar,
        "comision":comision,
        "lat": lat,
        "lng": lng,
        "id_usuario": idUsuario,
    };
}