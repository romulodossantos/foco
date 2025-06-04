import 'package:flutter/material.dart';
import 'task_screen.dart';        // Importa a tela de tarefas
import 'progress_screen.dart';   // Importa a tela do gráfico de progresso
import 'login_screen.dart';      // Importa a tela de login

void main() {
  runApp(const FocoApp());       // Ponto de entrada do app, roda o widget FocoApp
}

class FocoApp extends StatelessWidget {
  const FocoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foco',              // Título do app
      debugShowCheckedModeBanner: false, // Remove a tag "debug" no canto da tela
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Define cor principal azul
      ),
      initialRoute: '/',           // Rota inicial do app: tela de login
      routes: {
        '/': (context) => const LoginScreen(),      // Rota '/' carrega a tela de login
        '/tasks': (context) => const TaskScreen(),  // Rota '/tasks' carrega a tela de tarefas
        '/progresso': (context) => const ProgressScreen(), // Rota '/progresso' carrega o gráfico
      },
    );
  }
}
