import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CreateActivityScreen extends StatefulWidget {
  @override
  _CreateActivityScreenState createState() => _CreateActivityScreenState();
}

class _CreateActivityScreenState extends State<CreateActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _caloriesLostController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _finished = 'Não';
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return _userEmail = prefs.getString('user_email');
  }

  Future<void> _createActivity() async {
    final response = await http.post(
      Uri.parse('http://localhost:3333/scheduled-activities'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': _nameController.text,
        'start_date': _startDate?.toIso8601String(),
        'end_date': _endDate?.toIso8601String(),
        'distance': int.parse(_distanceController.text),
        'calories_lost': int.parse(_caloriesLostController.text),
        'steps': int.parse(_stepsController.text),
        'email': _userEmail,
        'finished': _finished,
      }),
    );

    if (response.statusCode == 201) {
      print('Atividade criada com sucesso!');
      Navigator.pop(context, true);
    } else {
      print('Falha ao criar atividade: ${response.statusCode}');
    }
  }

  Future<void> _selectDateTime(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          final selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          if (isStartDate) {
            _startDate = selectedDateTime;
          } else {
            _endDate = selectedDateTime;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Nova Atividade'),
        backgroundColor: const Color(0xFF171821),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  _startDate == null
                      ? 'Selecione a Data e Hora de Início'
                      : 'Início: ${DateFormat('dd/MM/yyyy HH:mm').format(_startDate!)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDateTime(context, true),
              ),
              ListTile(
                title: Text(
                  _endDate == null
                      ? 'Selecione a Data e Hora de Fim'
                      : 'Fim: ${DateFormat('dd/MM/yyyy HH:mm').format(_endDate!)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDateTime(context, false),
              ),
              TextFormField(
                controller: _distanceController,
                decoration: const InputDecoration(labelText: 'Distância'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a distância';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _caloriesLostController,
                decoration:
                    const InputDecoration(labelText: 'Calorias Perdidas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira as calorias perdidas';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stepsController,
                decoration: const InputDecoration(labelText: 'Passos'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade de passos';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _finished,
                decoration: const InputDecoration(labelText: 'Finalizado'),
                items: ['Não', 'Sim'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _finished = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione se a atividade foi finalizada';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Hero(
                tag: 'cadastrarAtividade',
                child: ElevatedButton(
                  onPressed: _createActivity,
                  child: const Text('Criar Atividade'),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF171821),
    );
  }
}
