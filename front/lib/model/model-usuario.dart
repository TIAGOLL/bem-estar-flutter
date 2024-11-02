// class Usuario {
//   final int id;
//   final String nome;
//   final String username;
//   final String senha;
//   final String email;
  
  

//   Usuario({
//     required this.id,
//     required this.nome,
//     required this.email,
//     required this.username,
//     required this.senha,
//   });
// }






import 'package:bem_estar_flutter/model/model-agenda.dart';

class Usuario {
  final int id;
  final String name;
  final String username;
  final String password;
  final String? avatar;
  final String? created_at;
  final String? updated_at;
  final String email;
  final List<AgendaModel> scheduled_activities;

  Usuario({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.avatar,
    required this.created_at,
    required this.updated_at,
    required this.email,
    required this.scheduled_activities,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      password: json['password'],
      avatar: json['avatar'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      email: json['email'],
      scheduled_activities: (json['scheduled_activities'] as List)
          .map((activity) => AgendaModel.fromJson(activity))
          .toList(),
    );
  }
}