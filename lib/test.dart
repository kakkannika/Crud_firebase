import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  const String baseUrl = "https://restaurants-reservations-ffe48-default-rtdb.asia-southeast1.firebasedatabase.app/";
  const String students = "students";
  const String allStudents = '$baseUrl/$students.json';

  Uri uri = Uri.parse(allStudents);
  final http.Response response = await http.get(uri);

  if (response.statusCode == HttpStatus.ok) {
    final data = json.decode(response.body) as Map<String, dynamic>?;
    List<Student> result = [];

    if (data != null) {
      result = data.entries.map((entry) => StudentDto.fromJson(entry.key, entry.value)).toList();
    }

    // Print first student's scores
    if (result.isNotEmpty) {
      print('Student ID: ${result[0].id}');
      print('Score 1: ${result[0].score1}');
      print('Score 2: ${result[0].score2}');
    }
  }
}

class StudentDto {
  static Student fromJson(String id, Map<String, dynamic> json) {
    return Student(
      id: id, 
      score1: json['score1'] ?? 0, 
      score2: json['score2'] ?? 0
    );
  }
}

class Student {
  final String id;
  final int score1;
  final int score2;

  Student({
    required this.id, 
    required this.score1, 
    required this.score2
  });
}