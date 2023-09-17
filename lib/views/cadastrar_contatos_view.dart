import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listacontatosapp/controller/cadastrar_contatos_controller.dart';
import 'package:provider/provider.dart';

class CadastrarContatosView extends StatefulWidget {
  const CadastrarContatosView({Key? key}) : super(key: key);

  @override
  State<CadastrarContatosView> createState() => _CadastrarContatosViewState();
}

class _CadastrarContatosViewState extends State<CadastrarContatosView> {
  final ImagePicker _picker = ImagePicker();
  FocusNode focusNodeNome = FocusNode();
  FocusNode focusNodeContato = FocusNode();

  pick(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        context.read<CadastrarContatosController>().selectedImage =
            File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CadastrarContatosController controller =
        Provider.of<CadastrarContatosController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar contato'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CircleAvatar(
                            backgroundImage: controller.selectedImage != null
                                ? FileImage(controller.selectedImage!)
                                : null,
                            backgroundColor: Colors.grey[900],
                            child: controller.selectedImage == null
                                ? const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 150,
                                  )
                                : const SizedBox()),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: const Icon(Icons.camera),
                                          title: const Text('Câmera'),
                                          onTap: () {
                                            Navigator.of(context)
                                                .pop(); // Fecha a BottomSheet
                                            // Implemente a lógica para abrir a câmera aqui
                                            pick(ImageSource.camera);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.image),
                                          title: const Text('Galeria'),
                                          onTap: () {
                                            Navigator.of(context)
                                                .pop(); // Fecha a BottomSheet
                                            // Implemente a lógica para abrir a galeria aqui
                                            pick(ImageSource.gallery);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.delete),
                                          title: const Text('Remover Foto'),
                                          onTap: () {
                                            Navigator.of(context)
                                                .pop(); // Fecha a BottomSheet
                                            // Implemente a lógica para remover a foto aqui
                                            setState(() {
                                              controller.selectedImage = null;
                                            });
                                          },
                                        ),
                                      ],
                                    ));
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Center(
              child: Text(
                "Qual é o seu nome?",
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: controller.nomeController,
                focusNode: focusNodeNome,
                onEditingComplete: () {
                  focusNodeNome.unfocus();
                  FocusScope.of(context).requestFocus(focusNodeContato);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  hintText: 'Digite seu nome',
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            const Center(
              child: Text(
                "Qual é o seu contato?",
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: controller.contatoController,
                focusNode: focusNodeContato,
                onEditingComplete: () {
                  focusNodeContato.unfocus();
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contato',
                  hintText: 'Digite seu contato',
                ),
              ),
            ),
            // Botão de cadastro
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: controller.saveContato,
                  child: const Text('Cadastrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
