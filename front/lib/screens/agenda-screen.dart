import 'package:bem_estar_flutter/widgets/menu-lateral.dart';
import 'package:flutter/material.dart';
import 'package:bem_estar_flutter/model/model-agenda.dart';
import 'package:bem_estar_flutter/data/data-agenda.dart';
import 'package:bem_estar_flutter/widgets/custom-card-widget.dart';
import 'package:bem_estar_flutter/widgets/cadastro-atividade-widget.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = DataAgenda();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        backgroundColor: const Color(0xFF171821),
      ),
      drawer: SizedBox(
        width: 250,
        child: MenuLateral(selectedIndex: 2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Agenda",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<AgendaModel>>(
                future: data.fetchTarefas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nenhuma tarefa encontrada'));
                  } else {
                    final tarefas = snapshot.data!;
                    return ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefas[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CustomCard(
                            color: Colors.black,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tarefa.titulo,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          tarefa.data,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.more),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateActivityScreen()),
                );
              },
              child: Text('Cadastrar Nova Atividade'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF171821),
    );
  }
}








/*
//tentativa falha

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = DataAgenda();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        backgroundColor: const Color(0xFF171821),
      ),
      drawer: SizedBox(
        width: 250,
        child: MenuLateral(selectedIndex: 2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Agenda",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<AgendaModel>>(
                future: data.fetchTarefas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nenhuma tarefa encontrada'));
                  } else {
                    final tarefas = snapshot.data!;
                    return ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefas[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CustomCard(
                            color: Colors.black,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tarefa.name,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Início: ${tarefa.startDate} - Fim: ${tarefa.endDate}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.more),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateActivityScreen()),
                );
              },
              child: Text('Cadastrar Nova Atividade'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF171821),
    );
  }
}
*/

