import 'dart:convert';
import 'package:bem_estar_flutter/data/data-usuario.dart';
import 'package:bem_estar_flutter/model/model-agenda.dart';
import 'package:http/http.dart' as http;

// class DataAgenda {
//   Future<List<AgendaModel>> fetchTarefas() async {
//     var response = await UsuariosData().getUserData();

//     // Supondo que 'tarefas' seja uma lista de tarefas no JSON retornado
//     List<dynamic> tarefasJson = response['tarefas'];
//     return tarefasJson.map((data) => AgendaModel.fromJson(data)).toList();
//   }

//   Future<dynamic> createScheduledActivity(Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('http://localhost:3333/user-data/bruno@teste.com'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(data),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body); // Retorna os dados da atividade criada
//     } else {
//       throw Exception('Falha ao cadastrar atividade');
//     }
//   }
// }




import 'package:bem_estar_flutter/model/model-usuario.dart';

class DataAgenda {
  // Busca as atividades agendadas do usuário
  Future<List<AgendaModel>> fetchTarefas() async {
    Usuario usuario = await UsuariosData().getUserData();
    print(await usuario);
    // Obtenha as atividades agendadas do usuário diretamente do objeto Usuario
    List<AgendaModel> atividadesJson = usuario.scheduled_activities;
    return atividadesJson;
  }

  // Cria uma nova atividade agendada
  Future<dynamic> createScheduledActivity(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('http://localhost:3333/user-data/bruno@teste.com'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Retorna os dados da atividade criada
    } else {
      throw Exception('Falha ao cadastrar atividade');
    }
  }
}


