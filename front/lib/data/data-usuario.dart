import 'dart:convert';
import 'package:bem_estar_flutter/model/model-agenda.dart';
import 'package:http/http.dart' as http;
import 'package:bem_estar_flutter/model/model-usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuariosData {
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<Usuario> getUserData() async {
    final userEmail = await getEmail();
    final response =
        await http.get(Uri.parse('http://localhost:3333/user-data/$userEmail'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Usuario(
        avatar: data['avatar'],
        created_at: data['created_at'],
        updated_at: data['updated_at'],
        id: data['id'],
        name: data['name'],
        username: data['username'],
        password: data['password'],
        email: data['email'],
        scheduled_activities: data['scheduled_activities'] != null
            ? (data['scheduled_activities'] as List)
                .map((activity) => AgendaModel.fromJson(activity))
                .toList()
            : [],
      );
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
          avatar: data['avatar'],
          created_at: data['created_at'],
          updated_at: data['updated_at'],
          id: data['id'],
          name: data['name'],
          username: data['username'],
          password: data['password'],
          email: data['email'],
          scheduled_activities: data['scheduled_activities'] != null
              ? (data['scheduled_activities'] as List)
                  .map((activity) => AgendaModel.fromJson(activity))
                  .toList()
              : [],
        );
      } else {
        print('Login inválido: usuário ou senha incorretos');
        return null;
      }
    } catch (e) {
      print('Erro ao realizar login: $e');
      return null;
    }
  }
}
