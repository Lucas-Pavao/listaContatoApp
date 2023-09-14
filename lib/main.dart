import 'package:flutter/material.dart';
import 'package:listacontatosapp/views/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [], child: const ListaContatos()));
}

class ListaContatos extends StatelessWidget {
  const ListaContatos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Contatos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.blueGrey,
          primarySwatch: Colors.red,
        ).copyWith(secondary: Colors.redAccent),
      ),
      home: const HomePage(),
    );
  }
}
