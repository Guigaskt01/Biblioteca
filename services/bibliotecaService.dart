import '../models/item_biblioteca.dart';
import '../models/usuario.dart';
import '../models/livro.dart';
import '../models/revista.dart';

class BibliotecaService {
  List<ItemBiblioteca> itens = [];
  List<Usuario> usuarios = [];
  final Map<Usuario, List<ItemBiblioteca>> emprestimos = {};

  void cadastrarUsuario(id, nome, email) {
    //Regra de negócio: 2
    for (Usuario usuario in usuarios) {
      if (usuario.id == id) {
        print("ID já existente!");
        //Sair do método caos ja exista um ID e interrompa o cadastro
        return;
      }
    }
    // Variável para ligar com objeto usuario
    Usuario usuario = Usuario();
    usuario.id = id;
    usuario.nome = nome;
    usuario.email = email;
    usuarios.add(usuario);
  }

  void cadastrarLivro(id, titulo, autor, ano, categoria) {
    //regra de negócio: 1
    for (ItemBiblioteca item in itens) {
      if (item.id == id) {
        print("ID já existente!");
        return;
      }
    }
    //Regra de negócio 7
    if (titulo.isEmpty) {
      print("Título não pode estar vazio!");
      return;
    }
    //Regra de negócio 6
    if (ano < 1000 || ano > 2026) {
      print("Ano de publicação não permitida!");
      return;
    }
    Livro livro = Livro();
    livro.id = id;
    livro.titulo = titulo;
    livro.autor = autor;
    livro.anoPublicacao = ano;
    livro.categoria = categoria;
    itens.add(livro);
  }

  void cadastrarRevista(id, titulo, ano, numeroEdicao) {
    //regra de negócio: 1
    for (ItemBiblioteca item in itens) {
      if (item.id == id) {
        print("ID já existente!");
        return;
      }
    }
    //Regra de negócio 7
    if (titulo.isEmpty) {
      print("Título não pode estar vazio!");
      return;
    }
    //Regra de negócio 6
    if (ano < 1000 || ano > 2026) {
      print("Ano de publicação não permitida!");
      return;
    }
    Revista revista = Revista();
    revista.id = id;
    revista.titulo = titulo;
    revista.anoPublicacao = ano;
    revista.edicao = numeroEdicao;
    itens.add(revista);
  }

  void listarItens() {
    for (ItemBiblioteca item in itens) {
      item.exibirInformacoes();
    }
  }

  void listarUsuarios() {
    for (Usuario usuario in usuarios) {
      print(usuario);
    }
  }

  void buscarItens(String pesquisa) {
    for (ItemBiblioteca item in itens) {
      if (item.titulo.contains(pesquisa)) {
        print(item);
      } else {
        print("Nenhum item encontrado!");
      }
    }
  }

  // Função realizar emprestimo
  void realizarEmprestimo(int idUser, int idItem) {
    Usuario? usuario;
    ItemBiblioteca? item;

    for (final usuarioCadastrado in usuarios) {
      if (usuarioCadastrado.id == idUser) {
        usuario = usuarioCadastrado;
        break;
      }
    }

    if (usuario == null) {
      print("Usuário não encontrado.");
      return;
    }

    for (final itemCadastrado in itens) {
      if (itemCadastrado.id == idItem) {
        item = itemCadastrado;
        break;
      }
    }

    if (item == null) {
      print("Item não encontrado.");
      return;
    }

    final itemEstaEmprestado = emprestimos.values.any(
      (itensEmprestados) =>
          itensEmprestados.any((itemEmprestado) => itemEmprestado.id == idItem),
    );

    if (itemEstaEmprestado) {
      print("Este item já está emprestado.");
      return;
    }

    if (usuario.quantidadeEmprestimos >= 3) {
      print("Usuário atingiu o limite de empréstimos.");
      return;
    }

    emprestimos.putIfAbsent(usuario, () => <ItemBiblioteca>[]).add(item);
    usuario.adicionarEmprestimo();
    print("Empréstimo realizado com sucesso.");
  }

  void realizarEmprestimos(int idUser, int idItem) {
    realizarEmprestimo(idUser, idItem);
  }

  // Função realizar Devolução
  void realizarDevolucao(int idItem) {
    Usuario? usuarioResponsavel;
    ItemBiblioteca? itemDevolvido;

    for (final entrada in emprestimos.entries) {
      for (final itemEmprestado in entrada.value) {
        if (itemEmprestado.id == idItem) {
          usuarioResponsavel = entrada.key;
          itemDevolvido = itemEmprestado;
          break;
        }
      }
      if (itemDevolvido != null) {
        break;
      }
    }

    if (usuarioResponsavel == null || itemDevolvido == null) {
      print("Este item não possui empréstimo ativo.");
      return;
    }

    final itensDoUsuario = emprestimos[usuarioResponsavel];
    itensDoUsuario?.remove(itemDevolvido);
    if (itensDoUsuario != null && itensDoUsuario.isEmpty) {
      emprestimos.remove(usuarioResponsavel);
    }

    usuarioResponsavel.removerEmprestimo();
    print("Devolução realizada com sucesso.");
  }
}
