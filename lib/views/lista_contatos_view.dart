import 'package:flutter/material.dart';

class ListaContatosView extends StatefulWidget {
  const ListaContatosView({super.key});

  @override
  State<ListaContatosView> createState() => _ListaContatosViewState();
}

class _ListaContatosViewState extends State<ListaContatosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de contatos'),
      ),
      body: const Center(
        child: Text('Lista de contatos'),
      ),
    );
  }
}
