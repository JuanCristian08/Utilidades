/*
um future representa uma operacao assincrona que retornara um unico valor no futuro ou um
erro.

QUANDO USAR
- quando voce espera um unico resultado
- ex: buscar dados da internet, ler um arquivo uma unica vez, salvar dados no banco

CARACTERISTICAS
- executa uma vez e finaliza
- pode retornar sucess (then) ou erro (cathError)
- pode ser aguardado com await
*/

//exemplo 1
import 'package:flutter_test/flutter_test.dart';

Future<String> fetchData(){
 // return Future.delayed(Duration(seconds: 2), () => 'Dados carregados');
 return Future.delayed(Duration(seconds: 2),() => throw Exception('falha ao buscar recursos'));
 }

//exemplo 2 - simular login
Future<bool> fazerlogin(String usuario, String senha) async {
  await Future.delayed(Duration(seconds: 2));
  if(usuario == 'admin' && senha == '1234'){
    return true;
  }

  throw Exception('Usuario/senha não conferem');
}

//exemplo 3 - localizacao
Future<String> obterLocalizacao() async{
  await Future.delayed(Duration(seconds: 2));
  return 'Lat: -23.0000 Lomg: -48.0000';
}

void main(List<String> args) async{
  //exemplo 1
  /*final dados = await fetchData();
  print(dados);*/

  //exemplo 2
  /* final sucesso = await fazerlogin('admin', '1234');
  print(sucesso); */

  //exemplo 3
/*   final local = await obterLocalizacao();
  print(local); */

  //tratando erros
  /* try{
    //codigo a ser executado caso funcione
  }catch(erro){
    //codigo a ser executado caso falhe
    print(erro.toString());
  } */

 try{
  final sucesso = await fazerlogin('admin', '1234');
  print(sucesso);
 }catch(e){
  print('Erro no login: $e');
 }
}

//