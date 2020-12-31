// To parse this JSON data, do
//
//     final jugadorModel = jugadorModelFromJson(jsonString);
// https://app.quicktype.io/
import 'dart:convert';

JugadorModel jugadorModelFromJson(String str) => JugadorModel.fromJson(json.decode(str));

String jugadorModelToJson(JugadorModel data) => json.encode(data.toJson());

class JugadorModel {
    JugadorModel({
        this.idJugador,
        this.cedulaIdentidad,
        this.idEquipo,
        this.apellidos,
        this.nombres,
        this.fotografiaUrl,
        this.sexo,
        this.fechaNacimiento,
        this.correo,
        this.nombreInstitucion,
        this.categoriaDeportiva,
    });

    int idJugador;
    String cedulaIdentidad;
    int idEquipo;
    String apellidos;
    String nombres;
    String fotografiaUrl;
    String sexo;
    DateTime fechaNacimiento;
    String correo;
    String nombreInstitucion;
    String categoriaDeportiva;

    factory JugadorModel.fromJson(Map<String, dynamic> json) => JugadorModel(
        idJugador: json["idJugador"],
        cedulaIdentidad: json["cedulaIdentidad"],
        idEquipo: json["idEquipo"],
        apellidos: json["apellidos"],
        nombres: json["nombres"],
        fotografiaUrl: json["fotografiaURL"],
        sexo: json["sexo"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        correo: json["correo"],
        nombreInstitucion: json["nombreInstitucion"],
        categoriaDeportiva: json["categoriaDeportiva"],
    );

    Map<String, dynamic> toJson() => {
        "idJugador": idJugador,
        "cedulaIdentidad": cedulaIdentidad,
        "idEquipo": idEquipo,
        "apellidos": apellidos,
        "nombres": nombres,
        "fotografiaURL": fotografiaUrl,
        "sexo": sexo,
        "fechaNacimiento": fechaNacimiento.toIso8601String(),
        "correo": correo,
        "nombreInstitucion": nombreInstitucion,
        "categoriaDeportiva": categoriaDeportiva,
    };
}

