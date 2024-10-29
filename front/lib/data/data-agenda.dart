/*import 'package:bem_estar_flutter/model/model-agenda.dart';

class DataAgenda {
  final tarefas = const [
    AgendaMoldel(titulo: "Corrida", data: "Hoje, 18:00 - 19:00"),
    AgendaMoldel(titulo: "Taekwondo", data: "Amanha, 17:00 - 18:00"),
    AgendaMoldel(titulo: "Musculacao", data: "Quarta-Feira, 07:00 - 08:00"),
    AgendaMoldel(titulo: "Taekwondo", data: "Quinta-Feira, 17:00 - 18:00"),
    AgendaMoldel(titulo: "Musculacao", data: "Quinta-Feira, 07:00 - 08-00")
  ];
}*/
import 'dart:convert';
import 'package:bem_estar_flutter/data/data-usuario.dart';
import 'package:bem_estar_flutter/model/model-agenda.dart';

class DataAgenda {
  Future<List<AgendaModel>> fetchTarefas() async {
    var response = await UsuariosData().getUserData();
    print(response);

    // Supondo que 'tarefas' seja uma lista de tarefas no JSON retornado
    List<dynamic> tarefasJson = response['tarefas'];
    return tarefasJson.map((data) => AgendaModel.fromJson(data)).toList();
  }
}
