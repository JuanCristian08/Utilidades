class TemperaturaModel {
  List<double> historico = [];

  void adicionar(double temperatura) {
    historico.add(temperatura);
    if (historico.length > 10) {
      historico.removeAt(0);
    }
  }

  static double calcularMedia(List<double> temperaturas) {
    return temperaturas.reduce((a, b) => a + b) / temperaturas.length;
  }
}
