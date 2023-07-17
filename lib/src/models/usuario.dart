import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    String? idUsuario;
    String? email;
    String? nombre;
    String? apellidos;
    String? celular;
    String? contrasenia;
    String? rol;
    String? sessionToken;

    Usuario({
        this.idUsuario,
        this.email,
        this.nombre,
        this.apellidos,
        this.celular,
        this.contrasenia,
        this.rol,
        this.sessionToken
        
    });


    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["id_usuario"],
        email: json["email"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        celular: json["celular"],
        contrasenia: json["contrasenia"],
        rol: json["rol"],
        sessionToken: json["session_token"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "email": email,
        "nombre": nombre,
        "apellidos": apellidos,
        "celular": celular,
        "contrasenia": contrasenia,
        "rol":rol,
        "session_token": sessionToken
    };
}
