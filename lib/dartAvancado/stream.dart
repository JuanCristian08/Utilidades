/*
uma stream representa uma fonte de evento/dados que ocorrem ao longo do tempo
QUANDO USAR
- quando voce precisa escutar atualizaçoes continuas.
- ex: GPS, mensagens de chat, digitacao em tempo real, evento do usuario

CARACTERISTICAS
- pode emitir valores com yield
- pode durar indefinidamente
- pode ser usada com listem ou await for
- devemos usar async* para declarar funcoes assincronas que retornam uma stream
 */

//exemplo 1 - contador de tempo
/* import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Stream<int> contarTempo() async*{
  for(int i = 0; i < 10; i++){
   await Future.delayed(Duration(seconds: 1));
   yield i;/*yield serve como um emissor, ele emite a nova informacao para a stream,
  como se fosse um return. porem sem finalizar a funcao.*/
  } 
}*/

//exemplo 2 - simulacao de chat
Stream<String> mensagemChat() async*{
  yield 'oi';
  await Future.delayed(Duration(seconds: 1));
  yield 'tudo bem?';
  await Future.delayed(Duration(seconds: 1));
  yield 'sim e vc?';
  await Future.delayed(Duration(seconds: 1));
  yield 'que bom!';
  await Future.delayed(Duration(seconds: 1));
  yield 'tchau';
}

/*void main(List<String> args) {
 contarTempo().listen(
    (event) => print('mensagem: $event'),
    onDone: () => print('stream finalizada'),
  ); */

/*   mensagemChat().listen(
    (mensagem) => print(mensagem),
    onDone: () => print('fim do chat.'),
  ); 
}*/
  //exemplos com controle de erro try cath
  Stream<int> contarTempo() async*{
    try{
      for(int i = 0; i < 10; i++){
        await Future.delayed(Duration(seconds: 1));
        if(i == 3){
          throw Exception('erro ao contar numero: $i');
        }
        yield i;
      }
    }catch(e){
      print('erro no contador de tempo: $e');
    }
  }

  void main(List<String> args) {
  contarTempo().listen(
    (event) => print('Numero: $event'),
    onError: (erro) => print(erro),
    onDone: () => print('finalizado'),
  );
}