import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
    String? idProducto;
    String? nombre;
    String? descripcion;
    double? precio;
    String? imagen;
    String? idCategoria;
    int? cantidad;

    Producto({
        this.idProducto,
        this.nombre,
        this.descripcion,
        this.precio,
        this.imagen,
        this.idCategoria,
        this.cantidad,
    });

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idProducto: json["id_producto"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio: json["precio"]?.toDouble(),
        imagen: json["imagen"],
        idCategoria: json["id_categoria"],
        cantidad: json["cantidad"],
    );

    static List<Producto> fromJsonList(List<dynamic> jsonList) {
      List<Producto> toList = [];
      jsonList.forEach((item) { 
        Producto producto = Producto.fromJson(item);
        toList.add(producto);
      });

      return toList;

    }

    Map<String, dynamic> toJson() => {
        "id_producto": idProducto,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "imagen": imagen,
        "id_categoria": idCategoria,
        "cantidad": cantidad,
    };
}