import 'dart:convert';
import 'package:dropdownbuttonformfield/models/jugador_model.dart';

import 'package:http/http.dart' as http;


class JugadorProvider {

  static const API = "http://gestionafutbol.com:3000/futbol";

  final headers = {
    'Authorization': 'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkVXN1YXJpbyI6MTAsImNvcnJlbyI6ImtsZWJlcnBvc2xpZ3VhQGdtYWlsLmNvbSJ9LCJpYXQiOjE2MDc0MDExMDMsImV4cCI6MTYzODkzNzEwM30.D3e7ruojbQFxZUXpFfyuCQF7p2IcmsmypEHHFOrzQgo',
    'Content-Type': 'application/json'
  };




  Future<List<JugadorModel>> getJugadores() async {
    final url  = '$API/jugador';
    final resp = await http.get(url, headers: headers);

    final decodedData = json.decode(resp.body);
    final List<JugadorModel> lista = new List();

    if ( decodedData == null ) return [];
    for(var item in decodedData){
      lista.add(JugadorModel.fromJson(item));
    }

    return lista;
  }


}

