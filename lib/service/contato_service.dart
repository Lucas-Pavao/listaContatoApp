import 'dart:convert';

import 'package:listacontatosapp/model/contato.dart';
import 'package:listacontatosapp/repository/contato_repository.dart';
import 'package:http/http.dart' as http;

class ContatoService extends ContatoRepository {
  final String _baseUrl = 'https://parseapi.back4app.com/classes/pessoa';
  final headers = {
    "X-Parse-Application-Id": "TZ2fnuA2ycTeVsuqM0Nn9XMIH60HTANnmJuUfKXs",
    "X-Parse-REST-API-Key": "YXulnHN7KwdEdBTDpz2Y0xv9pi1YJovz1g7epEtf",
    "Content-Type": "application/json"
  };

  @override
  Future<List<Contato>> findAll() async {
    try {
      var response = await http.get(
        Uri.parse(_baseUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var body = response.body;
        var json = jsonDecode(body);
        return (json['results'] as List)
            .map((e) => Contato.fromJson(e))
            .toList();
      } else {
        // Lida com um erro HTTP não esperado (por exemplo, 404, 500)
        throw Exception('Erro na solicitação HTTP: ${response.statusCode}');
      }
    } catch (e) {
      // Lida com exceções gerais, como erro de conexão
      throw Exception('Erro ao obter CEPs: $e');
    }
  }

  @override
  Future<Contato> save(Contato contato) async {
    try {
      var response = await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: jsonEncode(contato.toJson()),
      );

      if (response.statusCode == 201) {
        var body = response.body;
        var json = jsonDecode(body);
        return Contato.fromJson(json);
      } else {
        // Lida com um erro HTTP não esperado (por exemplo, 404, 500)
        throw Exception('Erro na solicitação HTTP: ${response.statusCode}');
      }
    } catch (e) {
      // Lida com exceções gerais, como erro de conexão
      throw Exception('Erro ao obter CEPs: $e');
    }
  }

  @override
  Future<Contato> update(Contato contato) async {
    try {
      var response = await http.put(
        Uri.parse('$_baseUrl/${contato.objectId}'),
        headers: headers,
        body: jsonEncode(contato.toJson()),
      );

      if (response.statusCode == 200) {
        var body = response.body;
        var json = jsonDecode(body);
        return Contato.fromJson(json);
      } else {
        // Lida com um erro HTTP não esperado (por exemplo, 404, 500)
        throw Exception('Erro na solicitação HTTP: ${response.statusCode}');
      }
    } catch (e) {
      // Lida com exceções gerais, como erro de conexão
      throw Exception('Erro ao obter CEPs: $e');
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      var response = await http.delete(
        Uri.parse('$_baseUrl/$id'),
        headers: headers,
      );

      if (response.statusCode != 200) {
        // Lida com um erro HTTP não esperado (por exemplo, 404, 500)
        throw Exception('Erro na solicitação HTTP: ${response.statusCode}');
      }
    } catch (e) {
      // Lida com exceções gerais, como erro de conexão
      throw Exception('Erro ao obter CEPs: $e');
    }
  }
}
