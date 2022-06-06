import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medicine/mytodolist/pages/todos_page.dart';
import 'package:medicine/mytodolist/providers/providers.dart';
import 'package:medicine/mytodolist/providers/todo_filter.dart';
import 'package:medicine/mytodolist/providers/todo_list.dart';
import 'package:medicine/mytodolist/providers/todo_search.dart';

void main() {
  runApp(const Mytodolist());
}

class Mytodolist extends StatelessWidget {
  const Mytodolist({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(initialActiveTodoCount: context.read<TodoList>().state.todos.length),
          update: (BuildContext context, TodoList todoList, ActiveTodoCount? activeTodoCount,) =>
          activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoFilter,
            TodoSearch,
            TodoList,
            FilteredTodos>(
          create: (context) => FilteredTodos(initialFilteredTodos: context.read<TodoList>().state.todos,),
          update: (BuildContext context,
              TodoFilter todoFilter,
              TodoSearch todoSearch,
              TodoList todoList,
              FilteredTodos? filteredTodos) =>
          filteredTodos!..update(todoFilter, todoSearch, todoList),
        ),
      ],
      child: MaterialApp(
        title: 'Todo Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
