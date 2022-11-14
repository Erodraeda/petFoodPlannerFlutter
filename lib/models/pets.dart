class Pets {
  int? id;
  String? nome;
  double? peso;
  int? idade;
  int? dieta;
  List<String>? doencas;
  String? racao;
  int? tamanhoPorcoes;
  int? userID;

  Pets();

  Pets.fromMap(Map map) {
    id = map['id'];
    nome = map['nome'];
    peso = map['peso'];
    idade = map['idade'];
    dieta = map['dieta'];
    doencas = map['doencas'];
    racao = map['racao'];
    tamanhoPorcoes = map['tamanhoPorcoes'];
    userID = map['userID'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nome': nome,
      'peso': peso,
      'idade': idade,
      'dieta': dieta,
      'doencas': doencas,
      'racao': racao,
      'tamanhoPorcoes': tamanhoPorcoes,
      'userID': userID,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return ("Id: $id, Nome: $nome, Peso: $peso, Idade: $idade, Dieta: $dieta, Doenças: $doencas, Ração: $racao, Tamanho das Porções: $tamanhoPorcoes, Dono do pet: $userID");
  }
}
