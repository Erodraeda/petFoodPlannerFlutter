// ignore_for_file: non_constant_identifier_names

class Alimentacao {
  int? id;
  int? pet_id;
  String? data_alimentacao;
  int? alimentacao1;
  int? alimentacao2;
  int? alimentacao3;

  Alimentacao.withA(this.pet_id, this.data_alimentacao, this.alimentacao1,
      this.alimentacao2, this.alimentacao3,
      [this.id]);

  Alimentacao();

  Alimentacao.fromMap(Map map) {
    id = map['id'];
    pet_id = map['pet_id'];
    data_alimentacao = map['data_alimentacao'];
    alimentacao1 = map['alimentacao1'];
    alimentacao2 = map['alimentacao2'];
    alimentacao3 = map['alimentacao3'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'pet_id': pet_id,
      'data_alimentacao': data_alimentacao,
      'alimentacao1': alimentacao1,
      'alimentacao2': alimentacao2,
      'alimentacao3': alimentacao3,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return ("Id: $id, Pet ID: $pet_id, Data da Alimentação: $data_alimentacao, Alimentação 1: $alimentacao1, Alimentação 2: $alimentacao2, Alimentação 3: $alimentacao3");
  }
}
