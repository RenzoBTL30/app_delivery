import 'dart:convert';

Categoria categoriaFromJson(String str) => Categoria.fromJson(json.decode(str));

String categoriaToJson(Categoria data) => json.encode(data.toJson());

class Categoria {
    String? idCategoria;
    String? nombre;

    Categoria({
        this.idCategoria,
        this.nombre,
    });

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        idCategoria: json["id_categoria"],
        nombre: json["nombre"],
    );

    static List<Categoria> fromJsonList(List<dynamic> jsonList) {
      List<Categoria> toList = [];
      jsonList.forEach((item) { 
        Categoria categoria = Categoria.fromJson(item);
        toList.add(categoria);
      });

      return toList;

    }

    Map<String, dynamic> toJson() => {
        "id_categoria": idCategoria,
        "nombre": nombre,
    };
}