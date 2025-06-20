import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class ConversorTemperatura extends StatefulWidget {
  const ConversorTemperatura({Key? key}) : super(key: key);

  @override
  State<ConversorTemperatura> createState() => _ConversorTemperaturaState();
}

class _ConversorTemperaturaState extends State<ConversorTemperatura> {
  late Future<double> _temperaturaInicial;
  late Stream<double> _streamTemperatura;
  List<double> _historicoTemperaturas = [];
  double? _mediaTemperaturas;

  @override
  void initState() {
    super.initState();
    _temperaturaInicial = _carregarTemperaturaInicial();
    _streamTemperatura = _simularTemperatura();
  }

  Future<double> _carregarTemperaturaInicial() async {
    await Future.delayed(const Duration(seconds: 2));
    return 25.0;
  }

  Stream<double> _simularTemperatura() async* {
    double temperaturaAtual = 25.0;
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      temperaturaAtual += (1 - 2 * (DateTime.now().second % 2));
      _historicoTemperaturas.add(temperaturaAtual);
      if (_historicoTemperaturas.length > 10) {
        _historicoTemperaturas.removeAt(0);
      }
      yield temperaturaAtual;
    }
  }

  void _calcularMediaEmIsolate() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_calcularMedia, [
      receivePort.sendPort,
      _historicoTemperaturas,
    ]);
    receivePort.listen((resultado) {
      setState(() {
        _mediaTemperaturas = resultado;
      });
    });
  }

  static void _calcularMedia(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final temperaturas = args[1] as List<double>;
    final media = temperaturas.reduce((a, b) => a + b) / temperaturas.length;
    sendPort.send(media);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversor de Temperatura"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color.fromARGB(255, 240, 6, 6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<double>(
              future: _temperaturaInicial,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Erro: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Text("Temperatura inicial: wi ${snapshot.data}°C");
                } else {
                  return const Text("Nenhuma temperatura encontrada.");
                }
              },
            ),
            const SizedBox(height: 16),
            StreamBuilder<double>(
              stream: _streamTemperatura,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Erro: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Text("Temperatura atual: ${snapshot.data}°C");
                } else {
                  return const Text("Nenhuma temperatura encontrada.");
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calcularMediaEmIsolate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                backgroundColor: const Color(0xFF8E2DE2),
                foregroundColor: Colors.white,
              ),
              child: const Text("Calcular média das últimas 10 temperaturas"),
            ),
            const SizedBox(height: 16),
            if (_mediaTemperaturas != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8E2DE2), Color.fromARGB(255, 240, 6, 6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  "Média das temperaturas: ${_mediaTemperaturas!.toStringAsFixed(2)}°C",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
