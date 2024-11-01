class Usuario {
  final int id;
  final String nome;
  final String username;
  final String senha;
  final String email;
  
  

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.username,
    required this.senha,
  });
}




/*
//tentativa falha

import 'package:bem_estar_flutter/model/model-agenda.dart';

class Usuario {
  final int id;
  final String nome;
  final String username;
  final String senha;
  final String email;
  final List<AgendaModel> scheduledActivities;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.username,
    required this.senha,
    required this.scheduledActivities,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['name'],
      username: json['username'],
      senha: json['password'],
      email: json['email'],
      scheduledActivities: (json['scheduled_activities'] as List)
          .map((activity) => AgendaModel.fromJson(activity))
          .toList(),
    );
  }
}*/