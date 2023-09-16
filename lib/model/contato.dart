import 'package:listacontatosapp/model/data_nascimento.dart';
import 'package:listacontatosapp/model/imagem.dart';

class Contato {
  String? objectId;
  DataNascimento? dataNascimento;
  Imagem? imagem;
  String? nome;
  String? createdAt;
  String? updatedAt;

  Contato(
      {this.objectId,
      this.dataNascimento,
      this.imagem,
      this.nome,
      this.createdAt,
      this.updatedAt});

  Contato.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    dataNascimento = json['dataNascimento'] != null
        ? DataNascimento.fromJson(json['dataNascimento'])
        : null;
    imagem = json['imagem'] != null ? Imagem.fromJson(json['imagem']) : null;
    nome = json['nome'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    if (dataNascimento != null) {
      data['dataNascimento'] = dataNascimento!.toJson();
    }
    if (imagem != null) {
      data['imagem'] = imagem!.toJson();
    }
    data['nome'] = nome;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
