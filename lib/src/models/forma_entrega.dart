import 'dart:convert';

FormaEntrega formaEntregaFromJson(String str) => FormaEntrega.fromJson(json.decode(str));

String formaEntregaToJson(FormaEntrega data) => json.encode(data.toJson());

class FormaEntrega {
    String? idFormaEntrega;
    String? descripcion;

    FormaEntrega({
        this.idFormaEntrega,
        this.descripcion,
    });

    factory FormaEntrega.fromJson(Map<String, dynamic> json) => FormaEntrega(
        idFormaEntrega: json["id_forma_entrega"],
        descripcion: json["descripcion"],
    );

    static List<FormaEntrega> fromJsonList(List<dynamic> jsonList) {
      List<FormaEntrega> toList = [];
      jsonList.forEach((item) { 
        FormaEntrega formaEntrega = FormaEntrega.fromJson(item);
        toList.add(formaEntrega);
      });
      return toList;
    }

    Map<String, dynamic> toJson() => {
        "id_forma_entrega": idFormaEntrega,
        "descripcion": descripcion,
    };
}