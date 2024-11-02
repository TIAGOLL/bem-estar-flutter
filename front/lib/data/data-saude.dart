import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bem_estar_flutter/model/model-saude.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSaude {
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<ModelSaude> fetchSaudeData() async {
    final userEmail = await getEmail();
    final response = await http.get(Uri.parse('http://localhost:3333/user-health-infos/$userEmail'));

    if (response.statusCode == 200) {
      return ModelSaude.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar os dados de saúde');
    }
  }
}
