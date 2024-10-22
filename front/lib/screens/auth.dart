import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Aplicando o tema escuro
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F30), // Cor de fundo escura da tela
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "../assets/images/logo.png", // Caminho para a imagem do logo
              height: 300,
            ),
            Text(
              'Bem-vindo de volta!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Usuário',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Color(0xFF2C2C38), // Cor de fundo do campo de texto
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Color(0xFF2C2C38), // Cor de fundo do campo de texto
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Ação de login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF4CAF50), // Nova propriedade para cor do botão
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Entrar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Ação de esqueci minha senha
              },
              child: Text(
                'Esqueci minha senha',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
