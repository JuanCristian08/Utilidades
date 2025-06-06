import 'package:flutter/material.dart';

class AboutModel {
  final String photoUrl;
  final List<String> aboutMe;
  final List<SocialLink> SocialLinks; 

  AboutModel({
    required this.photoUrl,
    required this.aboutMe,
    required this.SocialLinks,
  });
}

class SocialLink {
  final String name;
  final Widget icon;
  final color;
  final String url;

  SocialLink({
    required this.name,
    required this.icon,
    required this.color,
    required this.url,
  });
}
