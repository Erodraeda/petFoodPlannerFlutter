import 'package:PetFoodPlanner/models/pets.dart';

class User {
  int? id;
  String? nome;

  User();

  User.fromMap(Map map) {
    id = map['id'];
    nome = map['nome'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nome': nome,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return ("Id: $id, Nome: $nome");
  }
}
