import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mes_notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Table utilisateurs
    await db.execute('''
      CREATE TABLE utilisateurs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    // Table notes
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        contenu TEXT NOT NULL,
        dateCreation TEXT NOT NULL,
        dateModification TEXT NOT NULL,
        userId INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES utilisateurs (id)
      )
    ''');

    // Utilisateur par défaut : Marius / Marius#2026
    final hashedPassword = _hashPassword('Marius#2026');
    final userId = await db.insert('utilisateurs', {
      'username': 'Marius',
      'password': hashedPassword,
    });

    // Trois notes par défaut
    final now = DateTime.now().toIso8601String();
    await db.insert('notes', {
      'titre': 'Je dois apprendre les widgets Flutter',
      'contenu': 'Revoir les widgets de base : Container, Row, Column, Stack, ListView.',
      'dateCreation': now,
      'dateModification': now,
      'userId': userId,
    });
    await db.insert('notes', {
      'titre': 'Je dois faire un peu de sport',
      'contenu': '• Gymnastique\n• Endurance sur 3km\n• À 06h du matin avec Jean Sophos',
      'dateCreation': now,
      'dateModification': now,
      'userId': userId,
    });
    await db.insert('notes', {
      'titre': 'Je dois voir un documentaire sur l\'énergie renouvelable',
      'contenu': 'Documentaire à regarder sur les énergies propres et durables.',
      'dateCreation': now,
      'dateModification': now,
      'userId': userId,
    });
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  // Authentification
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final db = await database;
    final hashed = _hashPassword(password);
    final result = await db.query(
      'utilisateurs',
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashed],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }

  // Notes
  Future<List<Note>> getNotesByUser(int userId) async {
    final db = await database;
    final result = await db.query(
      'notes',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );
    return result.map((e) => Note.fromMap(e)).toList();
  }

  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<int> updateNote(Note note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}