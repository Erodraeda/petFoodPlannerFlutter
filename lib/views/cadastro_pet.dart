// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:PetFoodPlanner/views/myapp.dart';
import 'package:PetFoodPlanner/views/my_homepage.dart';

class CadastrarPet extends StatefulWidget {
  static const nomeRota = '/pet/register';

  const CadastrarPet({Key? key}) : super(key: key);

  @override
  State<CadastrarPet> createState() => _CadastrarPetState();
}

class _CadastrarPetState extends State<CadastrarPet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildMenu(),
        appBar: AppBar(
          title: const Text("Pet Food Planner - Cadastro"),
        ),
        body: Center(
            child: Column(children: [
          Row(children: [
            // Container(
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.deepPurple, width: 3.0)),
            //     child: TextField()), // TODO: não consigo colocar text field por algum motivo.
          ]),
        ])));
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
                // Navigator.pushNamed(context, CadastrarPet.nomeRota);
              }),
          ListTile(
              title: Text('Cadastre mais pets!'),
              onTap: () {
                Navigator.pushNamed(context, CadastrarPet.nomeRota);
              }),
          ListTile(
              title: Text('Configure os horários de alimentação!'),
              onTap: () {
                // Navigator.pushNamed(context, CadastrarPessoa.nomeRota);
              }),
        ],
      ),
    );
  }
}
