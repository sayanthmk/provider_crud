import 'package:crud_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StudentProvider with ChangeNotifier {
  List<StudentModel> _students = [];
  late Database _db;

  List<StudentModel> get students => _students;

  StudentProvider() {
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'student.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, country TEXT, phone TEXT, image TEXT)');
      },
    );
    await getAllStudents();
  }

  Future<void> addStudent(StudentModel student) async {
    await _db.rawInsert(
        'INSERT INTO student (name, age,country,phone,image)VALUES(?,?,?,?,?)',
        [
          student.name,
          student.age,
          student.country,
          student.phone,
          student.selectimage
        ]);
    await getAllStudents();
  }

  Future<void> deleteStudent(int id) async {
    await _db.delete('student', where: 'id = ?', whereArgs: [id]);
    await getAllStudents();
  }

  Future<void> updateStudent(StudentModel student) async {
    await _db.rawUpdate(
        'UPDATE student SET name = ?, age = ?,country=?,phone=?,image=? WHERE id = ?',
        [
          student.name,
          student.age,
          student.country,
          student.phone,
          student.selectimage,
          student.id
        ]);
    await getAllStudents();
  }

  Future<void> getAllStudents() async {
    final List<Map<String, dynamic>> maps = await _db.query('student');
    _students = List.generate(maps.length, (i) {
      return StudentModel.fromMap(maps[i]);
    });
    notifyListeners();
  }

  Future<void> searchStudent(String name) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      'student',
      where: 'LOWER(name) LIKE ?',
      whereArgs: ['%${name.toLowerCase()}%'],
    );
    _students = List.generate(maps.length, (i) {
      return StudentModel.fromMap(maps[i]);
    });
    notifyListeners();
  }
}
