import 'package:bem_estar_flutter/util/responsive.dart';
import 'package:bem_estar_flutter/widgets/atividades-widget.dart';
import 'package:bem_estar_flutter/widgets/grafico-barras.dart';
import 'package:bem_estar_flutter/widgets/grafico-linha.dart';
import 'package:bem_estar_flutter/widgets/header-widget.dart';
import 'package:bem_estar_flutter/widgets/perfil-widget.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            const HeaderWidget(),
            const SizedBox(height: 18),
            const AtividadesWidget(),
            const SizedBox(height: 18),
            const GraficoLinhaCard(),
            const SizedBox(height: 18),
            const GraficoBarras(),
            const SizedBox(height: 18),
            if (Responsive.isTablet(context)) const PerfilWidget(),
          ],
        ),
      ),
    );
  }
}
