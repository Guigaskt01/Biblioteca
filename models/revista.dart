import 'item_biblioteca.dart';

class Revista extends ItemBiblioteca{
  int edicao = 0;


  //Override serve para sobrepor o método original que vem de uma classe abstrata
  @override
  void exibirInformacoes() {
    print("ID: $id");
    print("Tipo: Revista");
    print("Título: $titulo");
    print("Ano: $anoPublicacao");
    print("Edição: $edicao");
  }
}