// models/mood_provider.dart
import 'package:flutter/material.dart';
import 'mood.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class MoodProvider with ChangeNotifier {
  List<Mood> _moods = [];
  Database? _database;

  List<Mood> get moods => _moods;

  MoodProvider() {
    _initDatabase(); // Initialize database when provider is created
  }

  Future<void> _initDatabase() async {
    _database = await _openDatabase();
    await _loadMoodsFromDatabase();
  }

  Future<Database> _openDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'moods.db');

    return await openDatabase(
      path,
      version: 2, // Increment the version number to force schema update
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE moods(id TEXT PRIMARY KEY, date TEXT, moodType TEXT, note TEXT, icon TEXT)', // Add icon field
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute(
              'ALTER TABLE moods ADD COLUMN icon TEXT'); // Add icon column if upgrading from older version
        }
      },
    );
  }

  Future<void> _loadMoodsFromDatabase() async {
    if (_database == null) return;

    final List<Map<String, dynamic>> maps = await _database!.query('moods');

    _moods = List.generate(maps.length, (i) {
      return Mood(
        id: maps[i]['id'],
        date: DateTime.parse(maps[i]['date']),
        moodType: maps[i]['moodType'],
        note: maps[i]['note'],
        icon: maps[i]['icon'], // Retrieve icon from the map
      );
    });

    notifyListeners();
  }

  Future<void> addMood(Mood mood) async {
    _moods.add(mood);
    notifyListeners();

    if (_database != null) {
      await _database!.insert(
        'moods',
        mood.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> removeMood(String id) async {
    _moods.removeWhere((mood) => mood.id == id);
    notifyListeners();

    if (_database != null) {
      await _database!.delete(
        'moods',
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}
