import 'package:listacontatosapp/model/imagem.dart';

class Contato {
  String? objectId;
  String? contato;
  Imagem? imagem;
  String? nome;

  Contato({
    this.objectId,
    this.contato,
    this.imagem,
    this.nome,
  });

  Contato.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    contato = json['contato'];
    imagem = json['imagem'] != null ? Imagem.fromJson(json['imagem']) : null;
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['contato'] = contato;
    if (imagem != null) {
      data['imagem'] = imagem!.toJson();
    }
    data['nome'] = nome;

    return data;
  }
}
