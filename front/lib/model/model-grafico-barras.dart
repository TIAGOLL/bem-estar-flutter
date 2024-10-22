import 'package:bem_estar_flutter/model/model-grafico.dart';
import 'package:flutter/material.dart';

class GraficoBarrasModel {
  final String titulo;
  final Color cor;
  final List<ModelGrafico> grafico;

  const GraficoBarrasModel(
      {required this.titulo, required this.cor, required this.grafico});
}