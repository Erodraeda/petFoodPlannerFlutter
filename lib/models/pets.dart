class Pets {
  int? id;
  String? nome;
  int? peso;
  String? idade;
  bool? dieta;
  List<String>? doencas;
  String? racao;
  int? tamanhoPorcoes;

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
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return ("Id: $id, Nome: $nome, Peso: $peso, Idade: $idade, Dieta: $dieta, Doenças: $doencas, Ração: $racao, Tamanho das Porções: $tamanhoPorcoes");
  }
}
