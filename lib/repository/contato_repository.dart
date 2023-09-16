import 'package:listacontatosapp/model/contato.dart';

abstract class ContatoRepository {
  Future<List<Contato>> findAll();
  Future<Contato> save(Contato contato);
  Future<Contato> update(Contato contato);
  Future<void> delete(int id);
}
