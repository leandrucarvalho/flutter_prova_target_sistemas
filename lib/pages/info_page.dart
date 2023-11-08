import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../service/info_storage.dart';
import 'text_store.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late InfoStorageService sharedStorage;
  late TextStore textStore;
  final FocusNode _textFocus = FocusNode();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sharedStorage = InfoStorageService();
    textStore = TextStore(sharedStorage);
    textStore.loadDataItem();
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  void showEditDialog(int index, String text) {
    final TextEditingController editTextController =
        TextEditingController(text: text);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Editar texto"),
          content: const Text("Tem certeza de que deseja editar este texto?"),
          actions: <Widget>[
            TextField(
              controller: editTextController,
              decoration:
                  const InputDecoration(hintText: "Digite o novo texto"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    textStore.editItem(index, editTextController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Editar"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar exclusão"),
          content: const Text("Tem certeza de que deseja excluir este texto?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                textStore.removeItem(index);
                Navigator.of(context).pop();
              },
              child: const Text("Excluir"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1e4e62),
              Color(0xFF1f4f63),
              Color(0xFF2c8687),
              Color(0xFF2d958e),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 310,
              width: 310,
              child: Card(
                elevation: 8,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Observer(
                        builder: (context) => Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                              color: Colors.black,
                            ),
                            itemCount: textStore.cardListItems.length,
                            itemBuilder: (context, index) {
                              final item = textStore.cardListItems[index];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showEditDialog(
                                        index,
                                        item,
                                      );
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.pencil,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDeleteDialog(index);
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.solidCircleXmark,
                                    ),
                                    color: Colors.red,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 310,
              child: TextField(
                focusNode: _textFocus,
                controller: textController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: const Center(
                    child: Text(
                      "Digite seu texto",
                    ),
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onEditingComplete: () {
                  if (textController.text.trim().isNotEmpty) {
                    var newData = textStore.cardListItems;
                    newData.add(textController.text);
                    textStore.addItem(newData);
                    textController.clear();
                    _textFocus.requestFocus();
                  } else {
                    showErrorMessage("Digite algum texto");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
