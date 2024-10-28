import 'package:bem_estar_flutter/model/model-menu.dart';
import 'package:bem_estar_flutter/screens/agenda-screen.dart';
import 'package:bem_estar_flutter/screens/auth.dart';
import 'package:bem_estar_flutter/screens/main_screen.dart';
import 'package:bem_estar_flutter/screens/profile-screen.dart';
import 'package:flutter/material.dart';

class MenuLateralData {
  final menu = <MenuModel>[
    MenuModel(
      icone: Icons.home,
      titulo: 'Geral',
      function: (context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      },
    ),
    MenuModel(
      icone: Icons.person,
      titulo: 'Perfil',
      function: (context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      },
    ),
    MenuModel(
      icone: Icons.event,
      titulo: 'Agenda',
      function: (context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AgendaScreen()));
      },
    ),
    MenuModel(
      icone: Icons.logout,
      titulo: 'Deslogar',
      function: (context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    ),
  ];
}
