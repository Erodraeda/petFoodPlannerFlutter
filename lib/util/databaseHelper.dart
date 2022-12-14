import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static const _databaseName = "petFoodPlanner.db";
  static const _databaseVersion = 1;
  static const table = 'pets';
  static const table2 = 'alimentacao';

  // torna esta classe singleton
  DatabaseHelper._privateConstructor(); //Construtor privado
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // tem somente uma referência ao banco de dados
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database!;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Database db;

    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      var databaseFactory = databaseFactoryFfi;
      db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      _onCreate(db, _databaseVersion);
    } else {
      var databasesPath = await getDatabasesPath();
      final path = '$databasesPath$_databaseName';
      db = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    }
    return db;
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, _databaseName);
    // return await openDatabase(path,
    //     version: _databaseVersion, onCreate: _onCreate);
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            id INTEGER PRIMARY KEY,
            nome TEXT NOT NULL,
            peso REAL NOT NULL,
            idade INTEGER NOT NULL,
            dieta INTEGER NOT NULL,
            racao TEXT,
            tamanhoPorcoes REAL
          )
          ''');
    await db.execute('''
          CREATE TABLE $table2 (
            id INTEGER PRIMARY KEY,
            pet_id INTEGER,
            data_alimentacao TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
            alimentacao1 INTEGER DEFAULT 0,
            alimentacao2 INTEGER DEFAULT 0,
            alimentacao3 INTEGER DEFAULT 0,
            FOREIGN KEY(pet_id) REFERENCES $table(id)
          )
          ''');
    await db.execute('''
          INSERT INTO $table (id, nome, peso, idade, dieta, racao, tamanhoPorcoes)
            VALUES (1, 'Samara', 4.3, 3, 0, 'Golden', 72)
          ''');
    await db.execute('''
          INSERT INTO $table (id, nome, peso, idade, dieta, racao, tamanhoPorcoes)
            VALUES (2, 'Yang', 5.2, 2, 1, 'Golden', 86)
          ''');
    await db.execute('''
          INSERT INTO $table (id, nome, peso, idade, dieta, racao, tamanhoPorcoes)
            VALUES (3, 'Cheddar', 3.8, 1, 0, 'Golden', 63)
          ''');
    await db.execute('''
          INSERT INTO $table2 (pet_id, alimentacao1, alimentacao2, alimentacao3)
            VALUES (1, 1, 0, 0)
          ''');
    await db.execute('''
          INSERT INTO $table2 (pet_id, alimentacao1, alimentacao2, alimentacao3)
            VALUES (2, 1, 0, 1)
          ''');
    await db.execute('''
          INSERT INTO $table2 (pet_id, alimentacao1, alimentacao2, alimentacao3)
            VALUES (3, 1, 1, 0)
          ''');
  }

  // métodos Helper
  //----------------------------------------------------
  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> insertFeeding(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table2, row);
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllFeedingRows() async {
    Database db = await instance.database;
    return await db.query(table2);
  }

  // Todos os métodos : inserir, consultar, atualizar e excluir,
  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<List<Map<String, dynamic>>> queryFeedingRow(int id) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table2 WHERE id = $id');
  }

  // Assumimos aqui que a coluna id no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateFeeding(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(table2, row, where: 'id = ?', whereArgs: [id]);
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
