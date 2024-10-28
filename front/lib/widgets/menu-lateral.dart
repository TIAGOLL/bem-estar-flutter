import 'package:flutter/material.dart';
import 'package:bem_estar_flutter/const/constant.dart';
import 'package:bem_estar_flutter/data/data-menu-lateral.dart';

class MenuLateral extends StatefulWidget {
  final int selectedIndex; // Adicione um campo para o índice selecionado

  const MenuLateral({super.key, this.selectedIndex = 0});

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex; // Defina o estado inicial
  }

  @override
  Widget build(BuildContext context) {
    final data = MenuLateralData();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFF171821),
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) => buildMenuEntry(data, index, context),
      ),
    );
  }

  Widget buildMenuEntry(MenuLateralData data, int index, BuildContext context) {
    final isSelected = selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0),
        ),
        color: isSelected ? selectionColor : Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          // Fechar o drawer e navegar para a nova tela
          Navigator.of(context).pop(); // Fecha o drawer
          // Usar Future.microtask para garantir que o drawer foi fechado
          Future.microtask(() {
            data.menu[index].function(context); // Executa a função de navegação
          });
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(
                data.menu[index].icone,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            Text(
              data.menu[index].titulo,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
