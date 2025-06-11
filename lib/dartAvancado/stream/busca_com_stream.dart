import 'dart:async';
import 'package:flutter/material.dart';

class BuscaComStream extends StatefulWidget {
  const BuscaComStream({super.key});

  @override
  State<BuscaComStream> createState() => _BuscaComStreamState();
}

class _BuscaComStreamState extends State<BuscaComStream> {
  final _controllerBusca = StreamController<String>();
  final List<String> _items = [
    'Maçã',
    'Banana',
    'Laranja',
    'Uva',
    'Pera',
    'Manga',
    'Abacaxi',
    'Kiwi',
    'Cereja',
    'Melancia'
  ];

  List<String> _filtrar(String termo) {
    return _items
        .where((item) => item.toLowerCase().contains(termo.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca com Stream'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => _controllerBusca.add(value),
              decoration: const InputDecoration(
                labelText: 'Digite sua busca',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<String>(
              stream: _controllerBusca.stream,
              builder: (context, snapshot) {
                final listaFiltrada = _filtrar(snapshot.data ?? '');
                return Expanded(
                  child: ListView.builder(
                    itemCount: listaFiltrada.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(listaFiltrada[index]),
                      );
                    },
                  ),
                ); 
              },
            ),
          ],
        ),
      ),
    );
  }
}
