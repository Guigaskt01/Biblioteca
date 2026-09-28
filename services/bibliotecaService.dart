import '../models/item_biblioteca.dart';
import '../models/usuario.dart';
import '../models/livro.dart';
import '../models/revista.dart';

// Classe de serviço da biblioteca, responsável por gerenciar os itens, usuários e empréstimos
// Métodos de cadastros estão estruturados para realizar validações antes de cadastrar os itens ou usuários, garantindo a integridade dos dados.
// Métodos de lista e busca permitem visualizar os itens e usuários cadastrados, bem como realizar buscas por título ou categoria.
// Métodos de empréstimo e devolução gerenciam o processo de empréstimos, verificando se o item está disponível e se o usuário pode realizar o empréstimo.
// Método de relatório gera informações sobre a biblioteca, como quantidade de itens, usuários, empréstimos ativos, ano médio dos livros, livro mais antigo
// e mais recente, e usuário com mais empréstimos. 


class BibliotecaService {

  List<ItemBiblioteca> itens = [];
  List<Usuario> usuarios = [];

  Set<String> categorias = {};

  final Map<Usuario, List<ItemBiblioteca>> emprestimos = {};

  // Função para cadastrar usuário
  void cadastrarUsuario(int id,String nome,String email) {
    //Regra de negócio: 2 
    for (Usuario usuario in usuarios) {
      if (usuario.id == id) {
        print("ID já existente!");
        //Sair do método caso ja exista um ID e interrompa o cadastro
        return;
      }
    }
    // Variável para ligar com objeto usuario
    Usuario usuario = Usuario(
      id,
      nome,
      email
    );
    
    usuarios.add(usuario);
  }

  // Função para cadastrar livro
  void cadastrarLivro(int id,String titulo,String autor,int ano,String categoria) {
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
    Livro livro = Livro(
      id,
      titulo,
      ano,
      autor,
      categoria
    );

    categorias.add(livro.categoria);
    itens.add(livro);
  }

  // Função para cadastrar revista
  void cadastrarRevista(int id, String titulo, int ano, int numeroEdicao) {
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
    Revista revista = Revista(
      id,
      titulo,
      ano,
      numeroEdicao
    );

    itens.add(revista);
  }

  // Função para listar itens
  void listarItens() {
    for (ItemBiblioteca item in itens) {
      item.exibirInformacoes();
    }
  }

  // Função para listar usuários
  void listarUsuarios() {
    for (Usuario usuario in usuarios) {
      print("ID: ${usuario.id}");
      print("Nome: ${usuario.nome}");
      print("Email: ${usuario.email}");
      print("Quantidade de Empréstimos: ${usuario.quantidadeEmprestimos}");
      print("-------------------------");
    }
  }

  // Função para buscar por título
  void buscarPorTitulo(String pesquisa) {
    bool encontrou = false;

    for (ItemBiblioteca item in itens) {
      if (item.titulo.toLowerCase().contains(pesquisa.toLowerCase())) {
        item.exibirInformacoes();
        encontrou = true;
      }
    }

    if (!encontrou) {
      print("Nenhum item encontrado!");
    }
  }

  // Função para buscar por categoria
  void buscarPorCategoria(String busca) {
    bool encontrou = false;

    for (ItemBiblioteca item in itens) {
      if (item is Livro) {
        if (item.categoria.contains(busca)) {
          item.exibirInformacoes();
          encontrou = true;
        }
      }
    }

    if (!encontrou) {
      print("Nenhum item encontrado!");
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

  // Função para realizar emprestimos
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

  // Função para gerar relatório da biblioteca
  void relatorioBiblioteca() 
  {

    int qtd_total = itens.length;
    int qtd_user = usuarios.length;
    int qtd_emprestimos_ativos = 0;

    // total de itens
    print("Quantidade Total de Itens : $qtd_total");

    // qntd livros
    final livros = itens.where((item) => item is Livro).toList();
    int qtd_livro = livros.length;


    print("Quantidade de Livro: $qtd_livro");
    
    // qntd revistas
    final revistas = itens.where((item) => item is Revista).toList();
    int qtd_revista = revistas.length;


    print("Quantidade de Revista: $qtd_revista");

    // qntd users
    print("Quantidade de Usuários: $qtd_user");


    // emprestimos ativos
    for (var emprestimo in emprestimos.entries) {
      qtd_emprestimos_ativos += emprestimo.value.length;
    }
    print("Quantidade de Empréstimos Ativos: $qtd_emprestimos_ativos");


    // ano médio dos livros
    final anosLivros = livros.map((livro) => livro.anoPublicacao).toList();    
    double media_ano_livros = qtd_livro > 0 ? anosLivros.reduce((a, b) => a + b) / qtd_livro : 0;
    print("Ano Médio dos Livros: $media_ano_livros");


    //livro mais antigo
    Livro? livroMaisAntigo;

    for (ItemBiblioteca item in itens) {
      if (item is Livro) {
      if (livroMaisAntigo == null ||
        item.anoPublicacao < livroMaisAntigo.anoPublicacao) {
        livroMaisAntigo = item;
        }
      }
    }

    if (livroMaisAntigo != null) {
      print(
      "Livro mais antigo: ${livroMaisAntigo.titulo} "
      "(${livroMaisAntigo.anoPublicacao})"
      );
    } else {
      print("Não há livros cadastrados.");
    }

    //Livro mais recente
    Livro? livroMaisRecente;

    for (ItemBiblioteca item in itens) {
      if (item is Livro) {
        if (livroMaisRecente == null ||
            item.anoPublicacao > livroMaisRecente.anoPublicacao) {
          livroMaisRecente = item;
        }
      }
    }

    if (livroMaisRecente != null) {
      print(
        "Livro mais recente: ${livroMaisRecente.titulo} "
        "(${livroMaisRecente.anoPublicacao})"
      );
    } else {
      print("Não há livros cadastrados.");
    }


    // usuario com mais emprestimos
    Usuario? usuarioMaisEmprestimos;
    int maxEmprestimos = 0;
    for (var entry in emprestimos.entries) {
      if (entry.value.length > maxEmprestimos) {
        maxEmprestimos = entry.value.length;
        usuarioMaisEmprestimos = entry.key;
      }
    }
    if (usuarioMaisEmprestimos != null) {
      print("Usuário com mais empréstimos: ${usuarioMaisEmprestimos.nome}");
    }
  }
}
