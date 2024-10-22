import 'package:bem_estar_flutter/data/data-agenda.dart';
import 'package:bem_estar_flutter/widgets/custom-card-widget.dart';
import 'package:flutter/material.dart';

class Agenda extends StatelessWidget {
  const Agenda({super.key});

  @override
  Widget build(BuildContext context) {
    final data = DataAgenda();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Agenda",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        for (var index = 0; index < data.tarefas.length; index++)
          Padding(
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
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            data.tarefas[index].data,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Icon(Icons.more),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
