import 'package:flutter/material.dart';
import 'package:utilidades/src/controllers/converter_controller.dart';
import 'package:utilidades/src/models/converter_model.dart';

class ConverterView extends StatefulWidget {
  const ConverterView({super.key});

  @override
  State<ConverterView> createState() => _ConverterViewState();
}

class _ConverterViewState extends State<ConverterView> {
  final controller = ConverterController();
  final inputController = TextEditingController();
  Unit selectFrom = Unit.meter;
  Unit selectTo = Unit.meter;
  String result = '';

  @override
  void initState() {
    super.initState();
    controller.initializeModel();
  }

  void converter() {
    setState(() {
      controller.setInputValue(inputController.text);
      controller.setUnits(selectFrom, selectTo);
      result = controller.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: inputController,
            decoration: InputDecoration(
              labelText: "Valor",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: unitDropdown(
                  selectFrom,
                  (u) => setState(() => selectFrom = u),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward, color: Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: unitDropdown(
                  selectTo,
                  (u) => setState(() => selectTo = u),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: converter,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Converter"),
          ),
          const SizedBox(height: 20),
          Text(
            "Resultado: $result",
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  DropdownButton<Unit> unitDropdown(
    Unit currentValue,
    ValueChanged<Unit> onChanged,
  ) {
    return DropdownButton<Unit>(
      value: currentValue,
      onChanged: (Unit? newValue) {
        if (newValue != null) onChanged(newValue);
      },
      isExpanded: true,
      underline: Container(
        height: 1,
        color: const Color.fromARGB(255, 254, 0, 0),
      ),
      items: Unit.values.map((unit) {
        return DropdownMenuItem<Unit>(
          value: unit,
          child: Text(ConverterModel.getUnitName(unit)),
        );
      }).toList(),
    );
  }
}
