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
