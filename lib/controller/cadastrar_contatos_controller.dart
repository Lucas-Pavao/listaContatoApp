import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:listacontatosapp/model/contato.dart';
import 'package:listacontatosapp/model/imagem.dart';
import 'package:listacontatosapp/repository/contato_repository.dart';
import 'package:listacontatosapp/service/contato_service.dart';

class CadastrarContatosController extends ChangeNotifier {
  // Lista de opções para os campos de seleção

  File? selectedImage;
  TextEditingController nomeController = TextEditingController();
  TextEditingController contatoController = TextEditingController();

  final ContatoRepository repository = ContatoService();

  Future<void> saveContato() async {
    try {
      String imageBase64 = base64Encode(selectedImage!.readAsBytesSync());

      var contato = Contato(
        nome: nomeController.text,
        contato: contatoController.text,
        imagem: Imagem(
            sType: "File",
            name: selectedImage!.path.split('/').last,
            url: imageBase64),
      );

      await repository.save(contato);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
