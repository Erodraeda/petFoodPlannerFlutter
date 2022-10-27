import 'package:flutter/material.dart';
import 'package:PetFoodPlanner/views/myapp.dart';
import 'package:PetFoodPlanner/views/cadastro_pet.dart';

class MyHomePage extends StatefulWidget {
  static const nomeRota = '/myhomepage';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildMenu(),
        appBar: AppBar(
          title: const Text("Pet Food Planner"),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 64.0, right: 64.0, top: 24.0, bottom: 8.0),
                    child: Container(
                      height: 120,
                      width: 50,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.deepPurple, width: 3.0)),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Nome do Gato',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      // child: const Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: EdgeInsets.only(right: 24.0),
                      //   ),
                      // ) // TODO: Adicionar checkboxes no lado direito do container
                    ),
                  );
                },
              ))
            ],
          ),
        ));
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
