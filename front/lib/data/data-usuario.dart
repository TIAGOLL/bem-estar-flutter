import 'dart:convert'; 
import 'package:http/http.dart' as http; 
import 'package:bem_estar_flutter/model/model-usuario.dart';

class UsuariosData {
  Future<Usuario?> validarLogin(String username, String senha) async {
    final url = Uri.parse('http://localhost:3333/auth');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': senha,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);

        return Usuario(
            id: data['id'],
            nome: data['name'],
            username: data['username'],
            senha: data['password'],
            email: data['email']);
      } else if (response.statusCode != 201) {
        print('Login inválido: usuário ou senha incorretos');
        return null;
      }
    } catch (e) {
      print('Erro ao realizar login: $e');
      return null;
    }
  }
}
