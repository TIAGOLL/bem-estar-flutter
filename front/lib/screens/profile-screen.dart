import 'package:bem_estar_flutter/widgets/menu-lateral.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:bem_estar_flutter/data/data-usuario.dart';
import 'package:bem_estar_flutter/model/model-usuario.dart';
import 'package:bem_estar_flutter/data/data-saude.dart';
import 'package:bem_estar_flutter/model/model-saude.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Usuario> futureUsuario;
  late Future<ModelSaude> futureSaudeData;

  @override
  void initState() {
    super.initState();
    futureUsuario = UsuariosData().getUserData();
    futureSaudeData = DataSaude().fetchSaudeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Color(0xFF171821),
      ),
      drawer: SizedBox(
        width: 250,
        child: MenuLateral(selectedIndex: 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<Usuario>(
                future: futureUsuario,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('Nenhum dado encontrado'));
                  } else {
                    final usuario = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(usuario.avatar ?? 'assets/profile_picture.png'),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            usuario.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  }
                },
              ),
              FutureBuilder<ModelSaude>(
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildMetricRow(Icons.local_fire_department, saudeData.totalCaloriesLost.toString(), 'Calorias Queimadas', Colors.red),
                        buildMetricRow(Icons.directions_walk, saudeData.totalSteps.toString(), 'Passos', Colors.blue),
                        buildMetricRow(Icons.directions_run, '${saudeData.totalDistance} km', 'Distância', Colors.green),
                        SizedBox(height: 20),
                        Text(
                          'Gráficos:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 200,
                          child: LineChart(LineChartData(
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 2000),
                                  FlSpot(1, 4000),
                                  FlSpot(2, 6000),
                                  FlSpot(3, 8000),
                                  FlSpot(4, 10000),
                                ],
                                isCurved: true,
                                color: Colors.blue,
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(show: false),
                              )
                            ],
                          )),
                        ),
                        buildBarChart('Atividade', Colors.blue),
                        buildBarChart('Nutrição', Colors.orange),
                        buildBarChart('Hidratação', Colors.teal),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF171821),
    );
  }

  Widget buildMetricRow(IconData icon, String value, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color),
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

  Widget buildBarChart(String title, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 150,
      child: Card(
        color: Color(0xFF2A2C36),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    barGroups: [
                      BarChartGroupData(
                          x: 0,
                          barRods: [BarChartRodData(toY: 5, color: color)]),
                      BarChartGroupData(
                          x: 1,
                          barRods: [BarChartRodData(toY: 6, color: color)]),
                      BarChartGroupData(
                          x: 2,
                          barRods: [BarChartRodData(toY: 7, color: color)]),
                      BarChartGroupData(
                          x: 3,
                          barRods: [BarChartRodData(toY: 8, color: color)]),
                    ],
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
