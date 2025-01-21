import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:breakpoint_app/model/Vice.dart';
import 'package:breakpoint_app/model/User.dart';
import 'package:breakpoint_app/model/DiaryEntry.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  _createDB(Database db, int version) async {
    // Tabela de usuários
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        username TEXT,
        email TEXT,
        password TEXT,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE logged_user (
        id TEXT PRIMARY KEY,
        username TEXT,
        email TEXT,
        token TEXT
      )
    ''');

    // Tabela de vices com a referência para o usuário
    await db.execute('''
      CREATE TABLE vices (
        id TEXT PRIMARY KEY,
        user_id TEXT,
        datesobriety TEXT,
        dateCreation TEXT,
        viceType TEXT,
        impactType TEXT,
        impactValue TEXT,
        description TEXT,
        reseted INTEGER,
        impactCost TEXT  -- Adiciona a coluna impactCost
      )
    ''');

     await db.execute('''
      CREATE TABLE diary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        text TEXT NOT NULL,
        emotion TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<void> saveLoggedUser(User user, String token) async {
  final db = await database;
  await db.insert(
    'logged_user',
    {
      'id': user.id,
      'username': user.username,
      'email': user.email,
      'token': token,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// Obter o usuário logado
Future<Map<String, dynamic>?> getLoggedUser() async {
  final db = await database;
  final result = await db.query('logged_user', limit: 1);
  return result.isNotEmpty ? result.first : null;
}

// Remover o usuário logado
Future<void> clearLoggedUser() async {
  final db = await database;
  await db.delete('logged_user');
}

  Future<void> insertDiaryEntry(DiaryEntry entry) async {
    final db = await database;
    await db.insert('diary', entry.toSQLite(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

    Future<List<DiaryEntry>> getAllDiarys() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('diary');
    return result.map((map) => DiaryEntry.fromSQLite(map)).toList();
  }

   Future<void> clearDiaryTable() async {
    final db = await database;
    await db.delete('diary');  // Apaga todos os registros da tabela 'diary'
  }


  Future<void> deleteDiaryEntry(int id) async {
    final db = await database;
    await db.delete('diary', where: 'id = ?', whereArgs: [id]);
  }

// Inserir um usuário
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recuperar todos os usuários
  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromJson(maps[i]);
    });
  }

  // Deletar um usuário (os vices relacionados serão removidos devido à regra de ON DELETE CASCADE)
  Future<void> deleteUser(String userId) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // Recuperar todos os vices de um usuário específico
  Future<List<Vice>> getVicesByUserId(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'vices',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) {
      return Vice.fromJson(maps[i]);
    });
  }

  Future<void> insertVice(Vice vice) async {
    final db = await database;
    await db.insert(
      'vices',
      vice.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(
        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA Inserted vice: ${vice.toJson()}"); // Verifique os dados salvos
  }

  Future<List<Vice>> getAllVices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('vices');
    print("All vices in database: $maps"); // Verifique o conteúdo retornado
    return List.generate(maps.length, (i) {
      return Vice.fromJson(maps[i]);
    });
  }

  Future<void> updateVice(Vice vice) async {
    final db = await database;
    await db.update(
      'vices',
      vice.toJson(),
      where: 'id = ?',
      whereArgs: [vice.id],
    );
  }

  Future<void> deleteVice(String id) async {
    final db = await database;
    await db.delete(
      'vices',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
