// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:PetFoodPlanner/views/myapp.dart';
import 'package:PetFoodPlanner/views/my_homepage.dart';
import 'package:PetFoodPlanner/views/cadastro_pet.dart';
import 'package:PetFoodPlanner/models/pets.dart';
import 'package:PetFoodPlanner/util/databaseHelper.dart';

class DetalhesPet extends StatefulWidget {
  static const nomeRota = '/petdetails';

  const DetalhesPet({Key? key}) : super(key: key);

  @override
  State<DetalhesPet> createState() => _DetalhesPetState();
}

class _DetalhesPetState extends State<DetalhesPet> {
  Pets? pet;

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildMenu(),
        appBar: AppBar(
          title: const Text("Pet Food Planner - Detalhes de seus Pets"),
        ),
        body: FutureBuilder<List>(
            initialData: List.empty(),
            future: _consultar(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        pet = snapshot.data![i];
                        return _buildRow(context, pet!);
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }

  Widget _buildRow(BuildContext context, Pets pet) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Card(
              elevation: 5,
              shadowColor: Colors.deepPurple,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xFFF5F5F5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(-0.75, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SelectionArea(
                              child: Text(
                            pet.nome!,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: SelectionArea(
                              child: Text(
                            'Idade: ${pet.idade!}',
                          )),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: SelectionArea(
                              child: Text(
                            'Peso: ${pet.peso!}',
                          )),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(-0.7, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SelectionArea(
                              child: Text(
                            'Ra????o: ${pet.racao!}',
                          )),
                          SelectionArea(
                              child: Text(
                            'Dieta? ${(pet.dieta!.toString() == '1') ? 'Sim' : 'N??o'}',
                          )),
                          SelectionArea(
                              child: Text(
                            'Tamanho das Por????es: ${pet.tamanhoPorcoes!}',
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Align(
                          child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.deepPurple,
                          size: 20,
                        ),
                        onPressed: () {
                          _confirmDialog(pet);
                        },
                      ),
                    ],
                  ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  Future<List<Pets>> _consultar() async {
    var db = DatabaseHelper.instance;
    var result = await db.queryAllRows();

    List<Pets>? list =
        result.isNotEmpty ? result.map((c) => Pets.fromMap(c)).toList() : null;

    return list!;
  }

  _delete(int? petID) async {
    var db = DatabaseHelper.instance;
    await db.delete(petID!);
    _voltarDialog();
  }

  Widget _buildMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
              height: 80.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 216, 202, 244),
                ),
                child: Text('Op????es'),
              )),
          ListTile(
              title: const Text('Lista de seus pets!'),
              onTap: () {
                Navigator.pushNamed(context, MyHomePage.nomeRota);
              }),
          ListTile(
              title: Text('Detalhes dos seus pets!'),
              onTap: () {
                Navigator.pushNamed(context, DetalhesPet.nomeRota);
              }),
          ListTile(
              title: Text('Cadastre mais pets!'),
              onTap: () {
                Navigator.pushNamed(context, CadastrarPet.nomeRota);
              }),
        ],
      ),
    );
  }

  _confirmDialog(Pets? pet) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              title: const Text('Aviso!'),
              content:
                  Text('Voc?? tem certeza que quer deletar o pet ${pet!.nome}'),
              actions: [
                TextButton(
                  child: Text('Confirmar'),
                  onPressed: () {
                    _delete(pet.id);
                  },
                ),
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  _voltarDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detalhes de pet'),
          content: const Text('Pet deletado com sucesso! :c'),
          actions: [
            TextButton(
              child: const Text('Voltar para a tela inicial'),
              onPressed: () {
                Navigator.pushNamed(context, DetalhesPet.nomeRota);
              },
            ),
          ],
        );
      },
    );
  }
}
