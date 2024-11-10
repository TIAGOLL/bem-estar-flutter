import 'package:bem_estar_flutter/widgets/cadastro-atividade-widget.dart';
import 'package:bem_estar_flutter/widgets/menu-lateral.dart';
import 'package:flutter/material.dart';
import 'package:bem_estar_flutter/model/model-agenda.dart';
import 'package:bem_estar_flutter/data/data-agenda.dart';
import 'package:bem_estar_flutter/widgets/custom-card-widget.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen>
    with SingleTickerProviderStateMixin {
  final data = DataAgenda();
  List<int> _removedItems = [];
  final AudioPlayer _audioPlayer = AudioPlayer(); // Instância do player

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
    // Reproduz o áudio ao iniciar a exclusão
    await _audioPlayer.play(AssetSource('../../assets/audios/audio.mp3'));

    setState(() {
      _removedItems.add(id); // Marca o item como removido para animação
    });

    await Future.delayed(const Duration(milliseconds: 400));

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
                        final isRemoved = _removedItems.contains(tarefa.id);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Stack(
                            children: [
                              // Card com FadeTransition
                              AnimatedOpacity(
                                opacity: isRemoved ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 400),
                                child: CustomCard(
                                  color: Colors.black,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    finalizarAtividade(
                                                        tarefa.id);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orange[900],
                                                    minimumSize:
                                                        const Size(100, 30),
                                                  ),
                                                  child:
                                                      const Text('Finalizar'),
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
                              ),
                              // Partículas para efeito de explosão
                              if (isRemoved)
                                Positioned.fill(
                                  child: Particles(
                                    numberOfParticles: 20,
                                    duration: const Duration(milliseconds: 400),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    speedOfParticles: 2.0,
                                    color: Colors.red,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Hero(
              tag: 'cadastrarAtividade',
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateActivityScreen(),
                    ),
                  );
                  if (result == true) {
                    setState(() {}); // Recarrega a lista de tarefas
                  }
                },
                child: const Text('Cadastrar Nova Atividade'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF171821),
    );
  }

  @override
  void dispose() {
    _audioPlayer
        .dispose(); // Libera o recurso de áudio quando o widget é destruído
    super.dispose();
  }
}

class Particle {
  Offset position;
  Offset velocity;
  double lifetime;
  Color color;

  Particle({
    required this.position,
    required this.velocity,
    required this.lifetime,
    required this.color,
  });

  void update() {
    position += velocity;
    lifetime -= 1;
    color = color.withOpacity(lifetime / 100);
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    particles.forEach((particle) {
      paint.color = particle.color;
      canvas.drawCircle(particle.position, 2, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particles extends StatefulWidget {
  final int numberOfParticles;
  final Duration duration;
  final double width;
  final double height;
  final double speedOfParticles;
  final Color color;

  Particles({
    required this.numberOfParticles,
    required this.duration,
    required this.width,
    required this.height,
    required this.speedOfParticles,
    required this.color,
  });

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(_updateParticles);
    _particles = createParticles();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Particle> createParticles() {
    final particles = <Particle>[];
    final centerX = widget.width / 2;
    final centerY = widget.height / 2;

    for (int i = 0; i < widget.numberOfParticles; i++) {
      particles.add(Particle(
        position: Offset(centerX, centerY),
        velocity: Offset(
          (0.5 - _random.nextDouble()) * widget.speedOfParticles,
          (0.5 - _random.nextDouble()) * widget.speedOfParticles,
        ),
        lifetime: 100,
        color: widget.color,
      ));
    }
    return particles;
  }

  void _updateParticles() {
    setState(() {
      _particles.removeWhere((particle) => particle.lifetime <= 0);
      _particles.forEach((particle) {
        particle.update();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParticlePainter(_particles),
      child: Container(),
    );
  }
}
