/*
programacao assincroan e um modelo de programacao onde as 
operacoes que podem levar tempo para serem concluidas (como 
chamadas de rede, leitura de arquivos ou espera por eventos)
 sao executadas sem vloquear o fluxo principal do programa

 CONCEITO TECNICO
 em vez de esperar uma tarefa demorada terminar antes de
 continuar, a programacao assincrona registra um callback
 (funcao do retorno) ou usa estruturas como future, stream,
 async/await para deletar a tarefa e continuar executando o 
 restante do codigo.quando a tarefa termina, o resultado
 é entregue automaticamente

 NO DART
 Future<T> => representa uma operacao assincrona que eventualmente
 retorna um valor tipo T

 async e await => permitem escrever codigo assincrono como se fosse sincrono

 Stream<T> => representa uma sequencia assincrona de valores (ex: eventos, dados em serie)
*/


void main(List<String> args){
  imprimeNumeros();
}
 void imprimeNumeros() async{
  numero1();
  await numero2();//aguarde o resultado da funcao
  numero3();
 }

 void numero1(){
  print('numero 1');
 }

 Future<void> numero2(){
  return Future.delayed(Duration(seconds: 2), () => print('numero 2'));
 }

 void numero3(){
  print('numero 3');
 }