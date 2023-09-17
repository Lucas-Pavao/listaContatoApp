import 'package:flutter/material.dart';
import 'package:listacontatosapp/components/list_row.dart';
import 'package:listacontatosapp/controller/lista_contatos_controller.dart';
import 'package:provider/provider.dart';

class ListaContatosView extends StatefulWidget {
  const ListaContatosView({super.key});

  @override
  State<ListaContatosView> createState() => _ListaContatosViewState();
}

class _ListaContatosViewState extends State<ListaContatosView> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    ListaContatosController listaContatosController =
        Provider.of<ListaContatosController>(context);

    FocusNode focusNodeNome = FocusNode();
    FocusNode focusNodeContato = FocusNode();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de contatos'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: listaContatosController.contatos.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      child: const CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    )
                  : ListView.builder(
                      itemCount: listaContatosController.contatos.length,
                      itemBuilder: (context, index) {
                        bool isSelected = _selectedIndex == index;
                        if (index < listaContatosController.contatos.length) {
                          return GestureDetector(
                            onLongPress: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                    SnackBar(
                                      content: const Text('Excluir contato?'),
                                      action: SnackBarAction(
                                        label: 'Excluir',
                                        onPressed: () {
                                          // Remova o item da lista quando a ação for pressionada
                                          listaContatosController.deleteContato(
                                              listaContatosController
                                                  .contatos[index]);
                                          setState(() {
                                            _selectedIndex =
                                                -1; // Ressalta a cor para o branco
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                  .closed
                                  .then((reason) {
                                if (reason != SnackBarClosedReason.action) {
                                  // A Snackbar foi fechada sem acionar a ação
                                  setState(() {
                                    _selectedIndex =
                                        -1; // Ressalta a cor para o branco
                                  });
                                }
                              });
                            },
                            child: ListRow(
                              nome: listaContatosController
                                      .contatos[index].nome ??
                                  "",
                              dataNascimento: listaContatosController
                                      .contatos[index].contato ??
                                  "",
                              isSelected: isSelected,
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    final keyboardHeight =
                                        MediaQuery.of(context)
                                            .viewInsets
                                            .bottom;

                                    return SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: keyboardHeight,
                                          top: 10,
                                          left: 10,
                                          right:
                                              10, // Defina a margem inferior para a altura do teclado
                                        ),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Editar Contato',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.edit,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              TextFormField(
                                                controller:
                                                    TextEditingController(
                                                  text: listaContatosController
                                                      .contatos[index].nome,
                                                ),
                                                focusNode: focusNodeNome,
                                                onEditingComplete: () {
                                                  focusNodeNome.unfocus();
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          focusNodeContato);
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Nome',
                                                ),
                                                onChanged: (value) {
                                                  listaContatosController
                                                      .contatos[index]
                                                      .nome = value;
                                                },
                                              ),
                                              TextFormField(
                                                controller:
                                                    TextEditingController(
                                                  text: listaContatosController
                                                      .contatos[index].contato,
                                                ),
                                                focusNode: focusNodeContato,
                                                onEditingComplete: () {
                                                  focusNodeContato.unfocus();
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Contato',
                                                ),
                                                onChanged: (value) {
                                                  listaContatosController
                                                      .contatos[index]
                                                      .contato = value;
                                                },
                                              ),
                                              const SizedBox(height: 16),
                                              ElevatedButton(
                                                onPressed: () {
                                                  listaContatosController
                                                      .updateContato(
                                                          listaContatosController
                                                              .contatos[index]);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Salvar'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          // Tratar o caso em que o índice está fora dos limites da lista.
                          return const SizedBox
                              .shrink(); // Ou qualquer outro widget vazio.
                        }
                      },
                    ),
            ),
          ],
        ));
  }
}
