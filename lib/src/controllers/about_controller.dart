import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utilidades/src/models/about_model.dart';

class AboutController {
  AboutModel getAbout() {
    return AboutModel(
      photoUrl:
          "https://avatars.githubusercontent.com/u/201950643?s=400&u=ff2211cac792185fd9f23b30b89cfbd8de4340da&v=4",

      aboutMe: [
        'Me chamo Juan Cristian Kunz de Borba, tenho 18 anos e sou natural de Blumenau/SC. '
        'Atualmente estou cursando o programa Entra21, onde aplico minhas habilidades em desenvolvimento mobile. '
        'Sou apaixonado por tecnologia e estou sempre em busca de aprender novas ferramentas e metodologias '
        'para criar soluções inovadoras e eficientes.',
      ],

      SocialLinks: [
        SocialLink(
          name: "LinkedIn",
          icon: const FaIcon(
            FontAwesomeIcons.linkedin,
            color: Color(0xFF0A66C2), 
            size: 28,
          ),
          color: const Color.fromARGB(255, 0, 123, 255), 
          url: "https://www.linkedin.com/in/juan-de-borba-9855882a0/",
        ),
        SocialLink(
          name: "GitHub",
          icon: const FaIcon(
            FontAwesomeIcons.github,
            color: Colors.black,
            size: 28,
          ),
          color: const Color.fromARGB(255, 0, 0, 0), 
          url: "https://github.com/JuanCristian08",
        ),
      ],
    );
  }
}
