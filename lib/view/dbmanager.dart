import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbStudentManager {
  Database? _database;

  Future openDb() async {
    _database = await openDatabase(join(await getDatabasesPath(), "student.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE student (id INTEGER PRIMARY KEY autoincrement,name TEXT,course TEXT)");
    });
  }

// insert table is ready

  insertStudent(Student student) async {
    await openDb();
    return await _database!.insert('student', student.toMap());
  }
// get student list from table

  Future<List<Student>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('student');
    return List.generate(maps.length, (i) {
      return Student(
          id: maps[i]['id'], name: maps[i]['name'], course: maps[i]['course']);
    });
  }

// student data update

  Future<int> updateStudent(Student student) async {
    await openDb();
    return await _database!.update('student', student.toMap(),
        where: "id=?", whereArgs: [student.id]);
  }

  // student record delete from table

  Future<void> deleteStudent(id) async {
    await openDb();
    await _database!.delete('student', where: "id=?", whereArgs: [id]);
  }
}

class Student {
  // ignore: prefer_typing_uninitialized_variables
  var id;
  String? name;
  String? course;

  Student({this.id, this.name, this.course});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'course': course,
    };
  }
}
