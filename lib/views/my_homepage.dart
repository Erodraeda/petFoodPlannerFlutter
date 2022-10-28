import 'package:flutter/material.dart';
import 'package:PetFoodPlanner/views/myapp.dart';
import 'package:PetFoodPlanner/views/cadastro_pet.dart';
import 'package:PetFoodPlanner/models/pets.dart';
import 'package:PetFoodPlanner/util/databaseHelper.dart';

class MyHomePage extends StatefulWidget {
  static const nomeRota = '/myhomepage';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Pets? pet;

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

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
                        return _buildRow(context, pet!);
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }

  Widget _buildRow(BuildContext context, Pets pet) {
    Row(children: [
      Expanded(
          child: ListTile(
        title: Text(pet.nome!),
      )),
      Expanded(
        child: Container(
            height: 120,
            width: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple, width: 3.0)),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked1,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked1 = value!;
                    });
                  },
                ),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked2,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked2 = value!;
                    });
                  },
                ),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked3,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked3 = value!;
                    });
                  },
                ),
              ],
            )),
      )
    ]);
    return ListTile(
      title: Text(pet.nome!),

      // child: Container(
      //             height: 120,
      //             width: 50,
      //             decoration: BoxDecoration(
      //                 border:
      //                     Border.all(color: Colors.deepPurple, width: 3.0)),
      //             child: const Align(
      //               alignment: Alignment.centerLeft,
      //               child: Padding(
      //                 padding: EdgeInsets.only(left: 24.0),
      //                 child: Text(
      //                   'Nome do Gato',
      //                   maxLines: 1,
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             // child: const Align(
      //             //   alignment: Alignment.centerRight,
      //             //   child: Padding(
      //             //     padding: EdgeInsets.only(right: 24.0),
      //             //   ),
      //             // ) // TODO: Adicionar checkboxes no lado direito do container
      //           ),
      // onTap: () {
      //   Navigator.pushReplacementNamed(context, DetalhesPet.nome)
      // }
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
