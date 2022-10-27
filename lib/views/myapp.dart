import 'package:flutter/material.dart';
import 'package:PetFoodPlanner/views/my_homepage.dart';
import 'package:PetFoodPlanner/views/cadastro_pet.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Food Planner',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: MyHomePage.nomeRota,
      routes: {
        MyHomePage.nomeRota: ((context) => const MyHomePage()),
        CadastrarPet.nomeRota: ((context) => const CadastrarPet()),
        // DetalhesPet.nomeRota: ((context) => DetalhesPet()),
      },
    );
  }
}
