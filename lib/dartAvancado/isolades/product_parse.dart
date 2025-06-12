import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';

class ProductParse extends StatefulWidget {
  const ProductParse({super.key});

  @override
  State<ProductParse> createState() => _ProductParseState();
}

class _ProductParseState extends State<ProductParse> {
  late Future<List<dynamic>> _items;

  @override
  void initState() {
    super.initState();
    _items = loadJson();
  }
//ler os dados do JSON sem isolate
/* Future<List<dynamic>> loadJson() async{
  final jsonString = await DefaultAssetBundle.of(context)
    .loadString('assets/data.json'); 
  final parsed = json.decode(jsonString);
  return parsed['items'] as List<dynamic>;
} */

//USANDO ISOLATE

Future<List<dynamic>> loadJson()async{
  final jsonString = await DefaultAssetBundle.of(context)
  .loadString('assets/data.json');

  return await Isolate.run((){
    final parsed = json.decode(jsonString);
    return parsed['items'] as List<dynamic>;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parse de produtos"),
      backgroundColor: Colors.blue),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: FutureBuilder<List<dynamic>>(
        future: _items,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro: ${snapshot.error}",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      product['nome'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      "Descrição: ${product['descricao'] ?? 'Sem descrição'}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Colors.blue,
                    ),
                    trailing: Text(
                      "R\$ ${product['preco']?.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "Nenhum dado encontrado.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
