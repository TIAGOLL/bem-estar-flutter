import 'package:bem_estar_flutter/data/data-saude.dart';
import 'package:bem_estar_flutter/model/model-saude.dart';
import 'package:bem_estar_flutter/widgets/custom-card-widget.dart';
import 'package:flutter/material.dart';

class HealthWidget extends StatefulWidget {
  const HealthWidget({super.key});

  @override
  _HealthWidgetState createState() => _HealthWidgetState();
}

class _HealthWidgetState extends State<HealthWidget> {
  late Future<ModelSaude> futureSaudeData;

  @override
  void initState() {
    super.initState();
    futureSaudeData = DataSaude().fetchSaudeData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelSaude>(
      future: futureSaudeData,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildMetricRow(
                    'assets/icons/burn.png',
                    saudeData.totalCaloriesLost.toString(),
                    'Calorias Perdidas',
                    Colors.red),
                buildMetricRow('assets/icons/steps.png',
                    saudeData.totalSteps.toString(), 'Passos', Colors.blue),
                buildMetricRow(
                    'assets/icons/distance.png',
                    saudeData.totalDistance.toString(),
                    'Km Distância',
                    Colors.green),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildMetricRow(
      String iconPath, String value, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(iconPath, width: 24, height: 24),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
