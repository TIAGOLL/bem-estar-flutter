import 'package:bem_estar_flutter/model/model-usuario.dart';

class UsuariosData {
  final List<Usuario> usuariosData = [
    Usuario(id: '1', nome: 'BrunoTeste', username: 'brunoTeste', senha: '123'),
    Usuario(id: '2', nome: 'TiagoTeste', username: 'tiagoTeste', senha: '123'),
  ];

  // Método para validar o login
  Usuario? validarLogin(String username, String senha) {
    return usuariosData.firstWhere(
      (usuario) => usuario.username == username && usuario.senha == senha,
      
    );
  }
}