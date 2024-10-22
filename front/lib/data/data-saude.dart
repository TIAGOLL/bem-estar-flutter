import 'package:bem_estar_flutter/model/model-saude.dart';

class DataSaude {
  final saudeData = const [
    ModelSaude(
        icone: 'assets/icons/burn.png',
        valor: "305",
        titulo: "Calorias perdidas"),
    ModelSaude(
        icone: 'assets/icons/steps.png',
         valor: "10,983", 
         titulo: "Passos"),
    ModelSaude(
        icone: 'assets/icons/distance.png', 
        valor: "7km", 
        titulo: "Distância"),
    ModelSaude(
        icone: 'assets/icons/sleep.png', 
        valor: "7h48m", 
        titulo: "Sono"),
  ];
}
