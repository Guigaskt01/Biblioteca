import 'item_biblioteca.dart';

class Livro extends ItemBiblioteca {
  String autor = '';
  String categoria = '';


  //Override serve para sobrepor o método original que vem de uma classe abstrata
  @override
  void exibirInformacoes() {
    print("ID: $id");
    print("Tipo: Livro");
    print("Título: $titulo");
    print("Autor: $autor");
    print("Ano: $anoPublicacao");
    print("Categoria: $categoria");
  }
}
