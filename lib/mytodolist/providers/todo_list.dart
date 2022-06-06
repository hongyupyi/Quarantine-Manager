import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicine/mytodolist/models/todos_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(todos: [
      Todo(id: '1', date: '2022.3.23',time: 'PM 01:00', whatTodo: 'study', temp: '36.5', covidCheck: 'Yes', symptom: 'Cough'),
      Todo(id: '2', date: '2022.3.24',time: 'PM 03:00',whatTodo: 'rest', temp: '37.1', covidCheck: 'No', symptom: 'Fever'),
      Todo(id: '3', date: '2022.3.28',time: 'PM 06:00', whatTodo: 'study', temp: '36.3', covidCheck: 'Yes', symptom: 'None above'),
    ]);
  }

  @override
  List<Object?> get props => [todos];

  @override
  bool get stringify => true;

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.initial();
  TodoListState get state => _state;

  void addTodo(String date, String time, String whatTodo, String temp,String covidTest, String symptom) {

    final newTodo = Todo(date: date,time: time,whatTodo: whatTodo,temp: temp,covidCheck: covidTest,symptom: symptom);
    final newTodos = [..._state.todos, newTodo];

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void editTodo(String id, String editDate,String editTime, String editWhatTodo, String editTemp,String editCovidTest, String editSymptom) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          id: id,
          date: editDate,
          time: editTime,
          whatTodo: editWhatTodo,
          temp: editTemp,
          covidCheck: editCovidTest,
          symptom: editSymptom,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, date: todo.date,time: todo.time,whatTodo: todo.whatTodo,temp: todo.temp,covidCheck: todo.covidCheck,symptom: todo.symptom, completed: !todo.completed,);
      }
      return todo;
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    final newTodos = _state.todos.where((Todo t) => t.id != todo.id).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}