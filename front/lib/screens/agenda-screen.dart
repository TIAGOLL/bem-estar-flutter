import 'package:bem_estar_flutter/widgets/menu-lateral.dart';
import 'package:flutter/material.dart';
import 'package:bem_estar_flutter/data/data-agenda.dart';
import 'package:bem_estar_flutter/widgets/custom-card-widget.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = DataAgenda();

    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
        backgroundColor: Color(0xFF171821),
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
            Text(
              "Agenda",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: data.tarefas.length,
                itemBuilder: (context, index) {
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
                                    data.tarefas[index].titulo,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    data.tarefas[index].data,
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
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF171821),
    );
  }
}
