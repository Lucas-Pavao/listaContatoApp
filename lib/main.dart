import 'package:flutter/material.dart';
import 'package:listacontatosapp/controller/cadastrar_contatos_controller.dart';
import 'package:listacontatosapp/controller/lista_contatos_controller.dart';
import 'package:listacontatosapp/views/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CadastrarContatosController(),
    ),
    ChangeNotifierProvider(
      create: (context) => ListaContatosController(),
    ),
  ], child: const ListaContatos()));
}

class ListaContatos extends StatelessWidget {
  const ListaContatos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Contatos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepOrange,
              accentColor: Colors.deepOrange,
              backgroundColor: Colors.black,
              errorColor: Colors.red,
              brightness: Brightness.dark)),
      home: const HomePage(),
    );
  }
}
