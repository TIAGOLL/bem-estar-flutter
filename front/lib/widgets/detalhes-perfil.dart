import 'package:bem_estar_flutter/widgets/custom-card-widget.dart';
import 'package:flutter/material.dart';
import 'package:bem_estar_flutter/data/data-saude.dart';
import 'package:bem_estar_flutter/model/model-saude.dart';

class DetalhesPerfil extends StatelessWidget {
  const DetalhesPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelSaude>(
      future: DataSaude().fetchSaudeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Nenhum dado de saúde encontrado'));
        } else {
          final saudeData = snapshot.data!;
          return CustomCard(
            color: const Color(0xFF2F353E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDetails('Passos', saudeData.totalSteps.toString()),
                buildDetails('Distância', '${saudeData.totalDistance} km'),
                buildDetails('Calorias Perdidas', saudeData.totalCaloriesLost.toString()),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildDetails(String key, String value) {
    return Column(
      children: [
        Text(
          key,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
