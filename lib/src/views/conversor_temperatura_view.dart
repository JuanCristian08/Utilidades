import 'package:flutter/material.dart';
import '../controllers/temperatura_controller.dart';

class ConversorTemperaturaView extends StatefulWidget {
  const ConversorTemperaturaView({Key? key}) : super(key: key);

  @override
  State<ConversorTemperaturaView> createState() => _ConversorTemperaturaViewState();
}

class _ConversorTemperaturaViewState extends State<ConversorTemperaturaView> {
  final TemperaturaController _controller = TemperaturaController();

  late Future<double> _temperaturaInicial;
  late Stream<double> _streamTemperatura;
  double? _mediaTemperaturas;

  @override
  void initState() {
    super.initState();
    _temperaturaInicial = _controller.carregarTemperaturaInicial();
    _streamTemperatura = _controller.simularTemperatura();
  }

  void _onCalcularMedia() {
    _controller.calcularMediaEmIsolate((resultado) {
      setState(() {
        _mediaTemperaturas = resultado;
      });
    });
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
                  return Text("Temperatura inicial: ${snapshot.data}°C");
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
              onPressed: _onCalcularMedia,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                  boxShadow: const [
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
