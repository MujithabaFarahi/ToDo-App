import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/logic/simple_bloc_observer.dart';
import 'package:todoapp/logic/todo_bloc.dart';
import 'package:todoapp/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  Bloc.observer = SimpleBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            surface: Colors.white,
            onSurface: Colors.black,
            primary: Colors.blueAccent,
            onPrimary: Colors.white,
            secondary: Colors.lightGreen,
            onSecondary: Colors.white),
      ),
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()..add(TodoStarted()),
        child: const HomeScreen(),
      ),
    );
  }
}
