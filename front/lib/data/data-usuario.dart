import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bem_estar_flutter/model/model-usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuariosData {
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<Map<String, dynamic>> getUserData() async {
    final userEmail = await getEmail();
    final response = await http.get(Uri.parse('http://localhost:3333/user-data/$userEmail'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar os dados do usuário');
    }
  }

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

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', data['email']);

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




/*
//tentativa falha
class UsuariosData {
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<Usuario> getUserData() async {
    final userEmail = await getEmail();
    final response = await http.get(Uri.parse('http://localhost:3333/user-data/$userEmail'));

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar os dados do usuário');
    }
  }

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
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', data['email']);
        return Usuario(
            id: data['id'],
            nome: data['name'],
            username: data['username'],
            senha: data['password'],
            email: data['email'],
            scheduledActivities: []); // Por enquanto, sem atividades
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
*/
