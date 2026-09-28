import 'item_biblioteca.dart';

class Revista extends ItemBiblioteca{
  int edicao ;

  //construtor
  Revista(int id, String titulo, int anoPublicacao, this.edicao)
      : super(id, titulo, anoPublicacao);

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