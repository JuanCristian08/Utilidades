import 'package:flutter/material.dart';
import 'package:utilidades/dartAvancado/future/login.dart';
import 'package:utilidades/src/app/app_menu.dart';
import 'package:utilidades/src/services/auth_services.dart';
import 'package:utilidades/src/views/login_view.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8E2DE2), Color.fromARGB(255, 240, 6, 6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Image.asset(
                "assets/images/2035509-200.png",
                width: 150,
              ),
            ),
          ),
          ...appMenuItems.map(
            (item) => ListTile(
              leading: Icon(item.icon, color: Colors.purple),
              title: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, item.route);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: Text("Logout"),
            onTap: (){
              AuthServices.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginView()), 
                (route) => false
              );
            },
          )
        ],
      ),
    );
  }
}
