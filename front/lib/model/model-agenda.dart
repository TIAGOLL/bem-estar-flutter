// class AgendaModel {
//   final String titulo;
//   final String data;

// AgendaModel({required this.titulo, required this.data});

// factory AgendaModel.fromJson(Map<String, dynamic> json) {
//   return AgendaModel(
//     titulo: json['titulo'],
//     data: json['data'],
//   );
// }

// }

class AgendaModel {
  final int calories_lost;
  final int distance;
  final String end_date;
  final String finished;
  final int id;
  final String name;
  final String start_date;
  final int steps;
  final int users_id;

  AgendaModel({
    required this.calories_lost,
    required this.distance,
    required this.end_date,
    required this.finished,
    required this.id,
    required this.name,
    required this.start_date,
    required this.steps,
    required this.users_id,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) {
    final finished = json['finished'] == true ? 'true' : 'false';

    return AgendaModel(
      calories_lost: json['calories_lost'],
      distance: json['distance'],
      end_date: json['end_date'],
      finished: finished,
      id: json['id'],
      name: json['name'],
      start_date: json['start_date'],
      steps: json['steps'],
      users_id: json['users_id'],
    );
  }
}
