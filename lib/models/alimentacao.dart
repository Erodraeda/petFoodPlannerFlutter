class Alimentacao {
  int? id;
  int? petID;
  DateTime? dataAlimentacao;
  int? alimentacao1;
  int? alimentacao2;
  int? alimentacao3;

  Alimentacao(int petID, DateTime dataAlimentacao, int alimentacao1,
      int alimentacao2, int alimentacao3);

  Alimentacao.fromMap(Map map) {
    id = map['id'];
    petID = map['petID'];
    dataAlimentacao = map['dataAlimentacao'];
    alimentacao1 = map['alimentacao1'];
    alimentacao2 = map['alimentacao2'];
    alimentacao3 = map['alimentacao3'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'petID': petID,
      'dataAlimentacao': dataAlimentacao,
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
    return ("Id: $id, Pet ID: $petID, Data da Alimentação: $dataAlimentacao, Alimentação 1: $alimentacao1, Alimentação 2: $alimentacao2, Alimentação 3: $alimentacao3");
  }
}
