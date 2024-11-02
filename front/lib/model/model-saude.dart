class ModelSaude {
  final int totalCaloriesLost;
  final int totalDistance;
  final int totalSteps;

  ModelSaude({
    required this.totalCaloriesLost,
    required this.totalDistance,
    required this.totalSteps,
  });

  factory ModelSaude.fromJson(Map<String, dynamic> json) {
    return ModelSaude(
      totalCaloriesLost: json['totalCaloriesLost'],
      totalDistance: json['totalDistance'],
      totalSteps: json['totalSteps'],
    );
  }
}
