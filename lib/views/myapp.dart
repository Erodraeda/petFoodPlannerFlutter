import 'package:flutter/material.dart';
import 'package:PetFoodPlanner/views/my_homepage.dart';

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
        // CadastrarPessoa.nomeRota: ((context) => const CadastrarPessoa()),
        // DetalhesAniversario.nomeRota: ((context) => DetalhesAniversario()),
      },
    );
  }
}
