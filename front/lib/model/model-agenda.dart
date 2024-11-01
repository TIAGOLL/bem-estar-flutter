class AgendaModel {
  final String titulo;
  final String data;


AgendaModel({required this.titulo, required this.data});

factory AgendaModel.fromJson(Map<String, dynamic> json) {
  return AgendaModel(
    titulo: json['titulo'],
    data: json['data'],
  );
}

  
}





/*
//tentativa falha

class AgendaModel {
  final String name;
  final String startDate;
  final String endDate;
  final int caloriesLost;
  final int userId;

  AgendaModel({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.caloriesLost,
    required this.userId,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) {
    return AgendaModel(
      name: json['name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      caloriesLost: json['calories_lost'],
      userId: json['user_id'],
    );
  }
}
*/


