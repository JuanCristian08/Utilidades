enum Unit{
  meter,
  centimeter,
  milimeter,
  kilometer,
  mile
}
class ConverterModel {
  double inputValue;
  Unit fromUnit;
  Unit toUnit;

 ConverterModel({
  required this.inputValue,
  required this.fromUnit,
  required this.toUnit
 });

 double _toMeters(){
  switch (fromUnit){
    case Unit.meter:
    return inputValue;

    case Unit.centimeter:
    return inputValue / 100;

    case Unit.milimeter:
    return inputValue / 1000;

    case Unit.kilometer:
    return inputValue * 1000;

    case Unit.mile:
    return inputValue * 1609.34;
  }
 }

 double convert(){
  final meters = _toMeters();
  switch(toUnit){
    case Unit.meter:
    return meters;

    case Unit.centimeter:
    return meters * 100;

    case Unit.milimeter:
    return meters * 1000;

    case Unit.kilometer:
    return meters / 1000;

    case Unit.mile:
    return meters / 1609.34;
  }
 }

 static String getUnitName(Unit unit){
  switch(unit){
    case Unit.meter:
    return "Metro";

    case Unit.centimeter:
    return "Centimetro";

    case Unit.kilometer:
    return "Kilômetro";

    case Unit.milimeter:
    return "Milimetro";

    case Unit.mile:
    return "Milha";
  }
 }
}