class Pets {
  int? id;
  String? nome;
  double? peso;
  int? idade;
  int? dieta;
  String? racao;
  double? tamanhoPorcoes;

  Pets();

  Pets.fromMap(Map map) {
    id = map['id'];
    nome = map['nome'];
    peso = map['peso'];
    idade = map['idade'];
    dieta = map['dieta'];
    racao = map['racao'];
    tamanhoPorcoes = map['tamanhoPorcoes'];
  }

  Map<String, dynamic> toMap() {
    var coeff = (peso! > 2) ? 3 : 1;

    var tamanhoPorcao = (((peso! * 1000) * 0.05) - dieta! * 5) / coeff;

    Map<String, dynamic> map = {
      'nome': nome,
      'peso': peso,
      'idade': idade,
      'dieta': dieta,
      'racao': racao,
      'tamanhoPorcoes': tamanhoPorcao
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return ("Id: $id, Nome: $nome, Peso: $peso, Idade: $idade, Dieta: $dieta, Ração: $racao, Tamanho das Porções: $tamanhoPorcoes");
  }
}
