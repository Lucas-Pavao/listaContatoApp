import 'package:flutter/material.dart';
import 'package:listacontatosapp/model/contato.dart';
import 'package:listacontatosapp/repository/contato_repository.dart';
import 'package:listacontatosapp/service/contato_service.dart';

class ListaContatosController extends ChangeNotifier {
  final List<Contato> _contatos = [];
  final ContatoRepository _contatoRepository = ContatoService();

  List<Contato> get contatos => _contatos;
  ListaContatosController() {
    _initializecontatos();
  }

  _initializecontatos() async {
    _contatos.clear();
    _contatos.addAll(await _contatoRepository.findAll());
    notifyListeners();
  }

  void getContatos(Contato contato) async {
    _contatoRepository.findAll().then((value) {
      _contatos.addAll(value);
      notifyListeners();
    });

    notifyListeners();
  }

  void deleteContato(Contato contato) async {
    _contatoRepository.delete(contato).then((value) {
      _contatos.removeWhere((element) => element.objectId == contato.objectId);
      notifyListeners();
    });
  }

  void updateContato(Contato contato) async {
    _contatoRepository.update(contato);
    notifyListeners();
  }
}
