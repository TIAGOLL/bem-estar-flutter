import 'package:bem_estar_flutter/widgets/menu-lateral.dart';
import 'package:flutter/material.dart';
import 'package:bem_estar_flutter/model/model-agenda.dart';
import 'package:bem_estar_flutter/data/data-agenda.dart';
import 'package:bem_estar_flutter/widgets/custom-card-widget.dart';
import 'package:bem_estar_flutter/widgets/cadastro-atividade-widget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final data = DataAgenda();

  String formatDateTime(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('dd:MM:yy HH:mm');
    return formatter.format(parsedDate);
  }

  Future<void> finalizarAtividade(int id) async {
    final response = await http.put(
      Uri.parse('http://localhost:3333/scheduled-activities/finalize/$id'),
    );
    if (response.statusCode == 200) {
      print('Atividade finalizada com sucesso!');
      setState(() {});
    } else {
      print('Falha ao finalizar atividade: ${response.statusCode}');
    }
  }

  Future<void> deletarAtividade(int id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3333/scheduled-activities/delete/$id'),
    );
    if (response.statusCode == 200) {
      print('Atividade deletada com sucesso!');
      setState(() {});
    } else {
      print('Falha ao deletar atividade: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    print(snapshot.error);
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhuma tarefa encontrada'));
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          'Início: ${formatDateTime(tarefa.start_date)} - Fim: ${formatDateTime(tarefa.end_date)}',
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
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    tarefa.finished == 'true'
                                        ? const Icon(Icons.check_circle,
                                            color: Colors.green)
                                        : ElevatedButton(
                                            onPressed: () {
                                              finalizarAtividade(tarefa.id);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.orange[900],
                                              minimumSize: const Size(100, 30),
                                            ),
                                            child: const Text('Finalizar'),
                                          ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        deletarAtividade(tarefa.id);
                                      },
                                    ),
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
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateActivityScreen()),
                );
                if (result == true) {
                  setState(() {}); // Recarrega a lista de tarefas
                }
              },
              child: const Text('Cadastrar Nova Atividade'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF171821),
    );
  }
}
