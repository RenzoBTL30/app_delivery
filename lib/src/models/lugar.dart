import 'dart:convert';

Lugar lugarFromJson(String str) => Lugar.fromJson(json.decode(str));

String lugarToJson(Lugar data) => json.encode(data.toJson());

class Lugar {
    String? idLugar;
    String? lugar;
    double? comision;

    Lugar({
        this.idLugar,
        this.lugar,
        this.comision,
    });

    factory Lugar.fromJson(Map<String, dynamic> json) => Lugar(
        idLugar: json["id_lugar"],
        lugar: json["lugar"],
        comision: json["comision"]?.toDouble(),
    );

    static List<Lugar> fromJsonList(List<dynamic> jsonList) {
      List<Lugar> toList = [];
      jsonList.forEach((item) { 
        Lugar lugar = Lugar.fromJson(item);
        toList.add(lugar);
      });
      return toList;
    }

    Map<String, dynamic> toJson() => {
        "id_lugar": idLugar,
        "lugar": lugar,
        "comision": comision,
    };
}