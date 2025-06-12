import 'package:flutter/material.dart';
import 'package:utilidades/src/models/menu_model.dart';
import 'package:utilidades/src/views/about_view.dart';
import 'package:utilidades/src/views/converter_view.dart';
import 'package:utilidades/src/views/home_view.dart';

final List<MenuModel> appMenuItems = [
  MenuModel(
    title: 'Home',
    icon: Icons.home_rounded,
    route: '/Home',
    page: const HomeView(),
  ),
  MenuModel(
    title: 'Sobre Mim',
    icon: Icons.person_3_rounded,
    route: '/about',
    page: AboutView(),
  ),
  MenuModel(
    title: 'Configurações',
    icon: Icons.settings_rounded,
    route: '/settings',
    page: Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: const Center(
        child: Text('Página de Configurações', style: TextStyle(fontSize: 18)),
      ),
    ),
  ),
  MenuModel(
    title: 'Ajuda',
    icon: Icons.help_outline_rounded,
    route: '/help',
    page: Scaffold(
      appBar: AppBar(title: const Text('Ajuda')),
      body: const Center(
        child: Text(
          'Página de Ajuda e Suporte',
          style: TextStyle(fontSize: 18),
        ),
      ),
    ),
  ),

 MenuModel(
  title: "Conversor de Medidas",
  icon: Icons.straighten, 
  route: "/converter-medidas", 
  page: const ConverterView(), 
),


  
];
