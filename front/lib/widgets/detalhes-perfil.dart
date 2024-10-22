import 'package:bem_estar_flutter/widgets/custom-card-widget.dart';
import 'package:flutter/material.dart';

class DetalhesPerfil extends StatelessWidget {
  const DetalhesPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: const Color(0xFF2F353E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDetails('Passos', '10983'),
          buildDetails('Distância', '7km'),
          buildDetails('Sono', '7hr'),
        ],
      ),
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
