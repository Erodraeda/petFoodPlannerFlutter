// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:PetFoodPlanner/views/detalhes_pet.dart';
import 'package:flutter/material.dart';
import 'package:PetFoodPlanner/models/pets.dart';
import 'package:PetFoodPlanner/views/my_homepage.dart';
import 'package:PetFoodPlanner/util/databaseHelper.dart';

class CadastrarPet extends StatefulWidget {
  static const nomeRota = '/pet/register';

  const CadastrarPet({Key? key}) : super(key: key);

  @override
  State<CadastrarPet> createState() => _CadastrarPetState();
}

class _CadastrarPetState extends State<CadastrarPet> {
  final _formKey = GlobalKey<FormState>();

  Pets? pet = Pets();

  final controllerNome = TextEditingController();
  final controllerPeso = TextEditingController();
  final controllerIdade = TextEditingController();
  final controllerRacao = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controllerNome.dispose();
    controllerPeso.dispose();
    controllerIdade.dispose();
    controllerRacao.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controllerNome.addListener(() {
      pet?.nome = controllerNome.text;
    });
    controllerPeso.addListener(() {
      pet?.peso = double.parse(controllerPeso.text);
    });
    controllerIdade.addListener(() {
      pet?.idade = int.parse(controllerIdade.text);
    });
    controllerRacao.addListener(() {
      pet?.racao = controllerRacao.text;
    });
  }

  int dieta = 0;

  bool validate = false;

  // referencia nossa classe single para gerenciar o banco de dados
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildMenu(),
        appBar: AppBar(
          title: const Text("Pet Food Planner - Cadastro"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: _formUI(),
            ),
          ),
        ));
  }

  Widget _formUI() {
    List<DropdownMenuItem<int>> menuItems = [
      DropdownMenuItem(value: 1, child: Text("Sim")),
      DropdownMenuItem(value: 0, child: Text("Não")),
    ];

    return Column(
      children: <Widget>[
        TextFormField(
          controller: controllerNome,
          decoration: const InputDecoration(hintText: 'Nome do seu bichinho'),
          maxLength: 40,
        ),
        TextFormField(
          controller: controllerPeso,
          decoration: const InputDecoration(hintText: 'Peso'),
          keyboardType: TextInputType.number,
          maxLength: 10,
        ),
        TextFormField(
          controller: controllerIdade,
          decoration: const InputDecoration(hintText: 'Idade'),
          keyboardType: TextInputType.number,
          maxLength: 10,
        ),
        DropdownButtonFormField(
          decoration: const InputDecoration(hintText: 'Dieta?'),
          onChanged: (int? newValue) {
            setState(() {
              pet?.dieta = newValue!;
            });
          },
          items: menuItems,
        ),
        TextFormField(
          controller: controllerRacao,
          decoration: const InputDecoration(hintText: 'Ração'),
          maxLength: 30,
        ),
        const SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: inserir,
          child: const Text('Enviar'),
        )
      ],
    );
  }

  inserir() {
    if (_formKey.currentState!.validate()) {
      // Sem erros na validação
      _formKey.currentState!.save();
      Map<String, dynamic> row = pet!.toMap();
      dbHelper.insert(row);
      _voltarDialog();
    } else {
      // erro de validação
      setState(() {
        validate = true;
      });
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

  _voltarDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastro de Pets'),
          content: const Text('Cadastro efetuado com sucesso!'),
          actions: [
            TextButton(
              child: const Text('Voltar para a tela inicial'),
              onPressed: () {
                Navigator.pushNamed(context, MyHomePage.nomeRota);
              },
            ),
          ],
        );
      },
    );
  }
}
