import 'package:PetFoodPlanner/models/pets.dart';

class User {
  int? id;
  String? nome;
  Pets? pets;

  User();

  User.fromMap(Map map) {
    id = map['id'];
    nome = map['nome'];
    pets = map['pets'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nome': nome,
      'pets': pets,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return ("Id: $id, Nome: $nome, Pets: $pets");
  }
}
