import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController(); // Controller para o campo Usuário
  final TextEditingController _passwordController = TextEditingController(); // Controller para o campo Senha

  String _errorMessage = '';  // Guarda mensagem de erro para mostrar ao usuário

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // Validação simples: se usuário e senha forem corretos, navega para a tela de tarefas
    if (username == 'admin' && password == '1234') {
      Navigator.pushReplacementNamed(context, '/tasks');  // Navega para a tela de tarefas, substituindo a de login
    } else {
      setState(() {
        _errorMessage = 'Usuário ou senha inválidos';    // Mostra mensagem de erro caso login falhe
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),  // Barra superior com o título
      body: Padding(
        padding: const EdgeInsets.all(24.0),       // Espaçamento nas bordas
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centraliza verticalmente os elementos
          children: [
            TextField(
              controller: _usernameController,            // Campo para digitar o usuário
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,            // Campo para digitar a senha
              obscureText: true,                           // Esconde os caracteres digitados
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 20),                    // Espaço entre os campos e o botão
            ElevatedButton(
              onPressed: _login,                           // Ao clicar chama a função _login
              child: const Text('Entrar'),
            ),
            if (_errorMessage.isNotEmpty)                  // Se houver mensagem de erro, exibe ela em vermelho
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              )
          ],
        ),
      ),
    );
  }
}
