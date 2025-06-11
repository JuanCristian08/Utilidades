import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _status = "Aguardando...";
  bool _carregando = false;

  //sempre que trabalhar com tarefas assicronas no flutter use initState
  @override
  void initState(){
    super.initState();
  }

  //simulando login
  Future<bool> autenticar(String usuario, String senha) async{
    await Future.delayed(Duration(seconds: 3)); 
    return usuario =="admin" && senha == "123456";
  }

void _fazerLogin() async {
  setState(() {
    _carregando = true;
    _status = "Aguardando autenticação...";
  });

  bool sucesso = await autenticar("admin", "123456");

  setState(() {
    _carregando = false;
    _status = sucesso ? "Login realizado com sucesso!" : "Usuário ou senha inválidos!";
  });
}

  


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login com future"),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if( _carregando) 
              CircularProgressIndicator(),
              SizedBox(height: 20),
            Text(_status, style: TextStyle(fontSize: 18),),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _carregando ? null: _fazerLogin,
              child:Text("Simular login"))
          ],
        ), 
      ),
    );
  }
}