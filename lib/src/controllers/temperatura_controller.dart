import 'dart:async';
import 'dart:isolate';
import '../models/temperatura_model.dart';

class TemperaturaController {
  final TemperaturaModel _model = TemperaturaModel();

  Future<double> carregarTemperaturaInicial() async {
    await Future.delayed(const Duration(seconds: 2));
    return 25.0;
  }

  Stream<double> simularTemperatura() async* {
    double temperaturaAtual = 25.0;
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      temperaturaAtual += (1 - 2 * (DateTime.now().second % 2));
      _model.adicionar(temperaturaAtual);
      yield temperaturaAtual;
    }
  }

  void calcularMediaEmIsolate(Function(double) onResult) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_calcularMediaIsolate, [
      receivePort.sendPort,
      List<double>.from(_model.historico),
    ]);

    receivePort.listen((media) {
      onResult(media);
    });
  }

  static void _calcularMediaIsolate(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final temperaturas = args[1] as List<double>;
    final media = TemperaturaModel.calcularMedia(temperaturas);
    sendPort.send(media);
  }
}
