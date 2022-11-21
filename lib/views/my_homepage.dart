// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:PetFoodPlanner/views/myapp.dart';
import 'package:PetFoodPlanner/views/cadastro_pet.dart';
import 'package:PetFoodPlanner/views/detalhes_pet.dart';
import 'package:PetFoodPlanner/models/pets.dart';
import 'package:PetFoodPlanner/util/databaseHelper.dart';

import '../models/alimentacao.dart';

class MyHomePage extends StatefulWidget {
  static const nomeRota = '/myhomepage';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Pets? pet;

  static int _len = 10;

  List<bool> isChecked1 = List.generate(_len, (index) => false);
  List<bool> isChecked2 = List.generate(_len, (index) => false);
  List<bool> isChecked3 = List.generate(_len, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildMenu(),
        appBar: AppBar(
          title: const Text("Pet Food Planner"),
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
                        return _buildRow(context, pet!, i);
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }

  Widget _buildRow(BuildContext context, Pets pet, int index) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color.fromARGB(255, 216, 202, 244),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(-0.85, 0),
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
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Color(0xFF95A1AC),
                        ),
                        child: CheckboxListTile(
                          value: isChecked1[index] ??= true,
                          onChanged: (newValue) async {
                            setState(() => isChecked1[index] = newValue!);
                            _inserir(pet, 1);
                          },
                          title: Text(
                            'Primeira refeição',
                          ),
                          tileColor: Color(0xFFF5F5F5),
                          dense: false,
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Color(0xFF95A1AC),
                        ),
                        child: CheckboxListTile(
                          value: isChecked2[index] ??= true,
                          onChanged: (newValue) async {
                            setState(() => isChecked2[index] = newValue!);
                            _inserir(pet, 2);
                          },
                          title: Text(
                            'Segunda refeição',
                          ),
                          tileColor: Color(0xFFF5F5F5),
                          dense: false,
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Color(0xFF95A1AC),
                        ),
                        child: CheckboxListTile(
                          value: isChecked3[index] ??= true,
                          onChanged: (newValue) async {
                            setState(() => isChecked3[index] = newValue!);
                            _inserir(pet, 3);
                          },
                          title: Text(
                            'Terceira refeição',
                          ),
                          tileColor: Color(0xFFF5F5F5),
                          dense: false,
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

  _inserir(Pets pet, int noAlimentacao) async {
    var db = DatabaseHelper.instance;
    var result = await db.queryFeedingRow(pet.id!);

    int? alimentacao1 = 0;
    int? alimentacao2 = 0;
    int? alimentacao3 = 0;

    if (noAlimentacao == 1) alimentacao1 = 1;
    if (noAlimentacao == 2) alimentacao2 = 1;
    if (noAlimentacao == 3) alimentacao3 = 1;

    List<Pets>? list =
        result.isNotEmpty ? result.map((c) => Pets.fromMap(c)).toList() : null;

    Alimentacao alimentacao = Alimentacao(
        pet.id!, DateTime.now(), alimentacao1, alimentacao2, alimentacao3);

    Map<String, dynamic> row = alimentacao.toMap();

    if (list == null) {
      db.insertFeeding(row);
    }
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
                child: Text('Opções'),
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
}
