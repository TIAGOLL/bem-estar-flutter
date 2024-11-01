import 'package:flutter/material.dart';
import 'package:bem_estar_flutter/data/data-agenda.dart';

class CreateActivityScreen extends StatefulWidget {
  @override
  _CreateActivityScreenState createState() => _CreateActivityScreenState();
}

class _CreateActivityScreenState extends State<CreateActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? startDate;
  String? endDate;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var response = await DataAgenda().createScheduledActivity({
        'name': name,
        'start_date': startDate,
        'end_date': endDate,
      });

      if (response != null) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar atividade')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Atividade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome da Atividade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da atividade.';
                  }
                  return null;
                },
                onSaved: (value) => name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data de Início (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de início.';
                  }
                  return null;
                },
                onSaved: (value) => startDate = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data de Fim (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de fim.';
                  }
                  return null;
                },
                onSaved: (value) => endDate = value,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Cadastrar Atividade'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
