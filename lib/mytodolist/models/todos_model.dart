import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class Todo extends Equatable {
  final String id;
  final String date;
  final String time;
  final String whatTodo;
  final String temp;
  final String covidCheck;
  final String symptom;
  final bool completed;

  Todo({
    String? id,
    required this.date,
    required this.time,
    required this.whatTodo,
    required this.temp,
    required this.covidCheck,
    required this.symptom,
    this.completed = false,
  }) : id = id ?? uuid.v4();

  @override
  List<Object?> get props => [id, date,time,whatTodo,temp,covidCheck,symptom, completed];

  @override
  bool get stringify => true;
}

  enum Filter {
  all,
    active,
    completed,
  }