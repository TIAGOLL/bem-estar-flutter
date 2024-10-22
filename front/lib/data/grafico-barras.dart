import 'package:bem_estar_flutter/model/model-grafico-barras.dart';
import 'package:bem_estar_flutter/model/model-grafico.dart';
import 'package:flutter/material.dart';

class GraficoBarra {
  final data = [
    const GraficoBarrasModel(
        titulo: "Atividade",
        cor: Color(0xFFFEB95A),
        grafico: [
          ModelGrafico(x: 0, y: 8),
          ModelGrafico(x: 1, y: 10),
          ModelGrafico(x: 2, y: 7),
          ModelGrafico(x: 3, y: 4),
          ModelGrafico(x: 4, y: 4),
          ModelGrafico(x: 5, y: 6),
        ]),
    const GraficoBarrasModel(
        titulo: "Nutrição",
        cor: Color(0xFFF2C8ED),
        grafico: [
          ModelGrafico(x: 0, y: 8),
          ModelGrafico(x: 1, y: 10),
          ModelGrafico(x: 2, y: 9),
          ModelGrafico(x: 3, y: 6),
          ModelGrafico(x: 4, y: 6),
          ModelGrafico(x: 5, y: 7),
        ]),
    const GraficoBarrasModel(
        titulo: "Hidratação",
        cor: Color(0xFF20AEF3),
        grafico: [
          ModelGrafico(x: 0, y: 7),
          ModelGrafico(x: 1, y: 10),
          ModelGrafico(x: 2, y: 7),
          ModelGrafico(x: 3, y: 4),
          ModelGrafico(x: 4, y: 4),
          ModelGrafico(x: 5, y: 10),
        ]),
  ];

  final titulo = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
}
