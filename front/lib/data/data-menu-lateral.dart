import 'package:bem_estar_flutter/model/model-menu.dart';
import 'package:flutter/material.dart';

class MenuLateralData {
  final menu = const <MenuModel>[
    MenuModel(icone: Icons.home, titulo: 'Geral'),
    MenuModel(icone: Icons.person, titulo: 'Perfil'),
    MenuModel(icone: Icons.logout, titulo: 'Deslogar'),
  ];
}
