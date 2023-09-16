import 'dart:async';
import 'dart:io';
import 'dart:math';

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
      body: Column(
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
                      ),
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
          const SizedBox(
            height: 50,
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
                hintText: 'Digite seu nome',
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          const Center(
            child: Text(
              "Quando você nasceu?",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: controller.selectedDia,
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.selectedDia = newValue;
                      });
                    },
                    items: controller.dias
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text('Dia'),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Expanded(
                  child: DropdownButton<String>(
                    value: controller.selectedMes,
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.selectedMes = newValue;
                      });
                    },
                    items: controller.meses
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text('Mês'),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Expanded(
                  child: DropdownButton<String>(
                    value: controller.selectedAno,
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.selectedAno = newValue;
                      });
                    },
                    items: controller.anos
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: const Text('Ano'),
                  ),
                ),
              ],
            ),
          ),

          // Botão de cadastro
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Cadastrar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
