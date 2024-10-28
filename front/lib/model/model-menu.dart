import 'package:flutter/material.dart';

class MenuModel {
  final IconData icone;
  final String titulo;
  final Function(BuildContext) function;
  const MenuModel({
    required this.icone,
    required this.titulo,
    required this.function,
  });
}
