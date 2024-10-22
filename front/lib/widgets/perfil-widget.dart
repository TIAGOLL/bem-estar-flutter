import 'package:bem_estar_flutter/const/constant.dart';
import 'package:bem_estar_flutter/widgets/grafico-pizza.dart';
import 'package:bem_estar_flutter/widgets/agenda-widget.dart';
import 'package:bem_estar_flutter/widgets/detalhes-perfil.dart';
import 'package:flutter/material.dart';

class PerfilWidget extends StatelessWidget {
  const PerfilWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Chart(),
            Text(
              'Perfil',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            DetalhesPerfil(),
            SizedBox(height: 40),
            Agenda(),
          ],
        ),
      ),
    );
  }
}
