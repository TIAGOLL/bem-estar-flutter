//import 'package:bem_estar_flutter/const/constant.dart';
import 'package:bem_estar_flutter/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:bem_estar_flutter/data/data-usuario.dart';
import 'package:bem_estar_flutter/model/model-usuario.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late Future<Usuario> futureUsuario;

  @override
  void initState() {
    super.initState();
    futureUsuario = UsuariosData().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usuario>(
      future: futureUsuario,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Nenhum dado encontrado'));
        } else {
          final usuario = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!Responsive.isDesktop(context))
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.menu,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              if (Responsive.isMobile(context))
                Row(
                  children: [
                    InkWell(
                      onTap: () => Scaffold.of(context).openEndDrawer(),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(usuario.avatar ?? 'assets/images/avatar.png'),
                        radius: 16,
                      ),
                    ),
                  ],
                ),
            ],
          );
        }
      },
    );
  }
}

