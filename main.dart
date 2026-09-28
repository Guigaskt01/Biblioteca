import 'services/bibliotecaService.dart';
import 'dart:io';


void main() {
  stdout.encoding = SystemEncoding();
  BibliotecaService biblioteca = BibliotecaService();
  


  while (true) {

    print("""
    ========================================
    SISTEMA DE BIBLIOTECA
    ========================================
    1 - Cadastrar livro
    2 - Cadastrar revista
    3 - Cadastrar usuário
    4 - Listar itens
    5 - Listar usuários
    6 - Realizar empréstimo
    7 - Realizar devolução
    8 - Buscar itens
    9 - Relatório da biblioteca
    0 - Sair
    Escolha uma opção:
    """); 


      String? opcao = stdin.readLineSync();

      switch (opcao) {
        case '1':

          // Solicita o ID do livro ao usuário
          print("Digite o ID do livro:");
          int idLivro = int.parse(stdin.readLineSync()!);


          // Solicita o título do livro ao usuário
          print("Digite o título do livro:");
          String tituloLivro = stdin.readLineSync()!;


          // Solicita o autor do livro ao usuário
          print("Digite o autor do livro:");
          String autorLivro = stdin.readLineSync()!;


          // Solicita o ano de publicação do livro ao usuário
          print("Digite o ano de publicação do livro:");
          int anoLivro = int.parse(stdin.readLineSync()!);


          // Solicita a categoria do livro ao usuário
          print("Digite a categoria do livro:");
          String categoriaLivro = stdin.readLineSync()!;

          // Chama o método cadastrarLivro do serviço de biblioteca ( instancia )
          biblioteca.cadastrarLivro(idLivro, tituloLivro, autorLivro, anoLivro, categoriaLivro);

          break;

        case '2':

          // Solicita os dados da revista ao usuário
          print("Digite o ID da revista:");
          int idRevista = int.parse(stdin.readLineSync()!);

          // Solicita o título da revista ao usuário
          print("Digite o título da revista:");
          String tituloRevista = stdin.readLineSync()!;

          // Solicita o ano de publicação da revista ao usuário
          print("Digite o ano de publicação da revista:");
          int anoRevista = int.parse(stdin.readLineSync()!);

          // Solicita o número da edição da revista ao usuário
          print("Digite o número da edição da revista:");
          int numeroEdicao = int.parse(stdin.readLineSync()!);

          // Chama o método cadastrarRevista do serviço de biblioteca ( Instancia )
          biblioteca.cadastrarRevista(idRevista, tituloRevista, anoRevista, numeroEdicao);

          break;

        case '3':

          // Solicita o ID do usuário ao usuário
          print("Digite o ID do usuário:");
          int idUsuario = int.parse(stdin.readLineSync()!);

          // Solicita o nome do usuário ao usuário
          print("Digite o nome do usuário:");
          String nomeUsuario = stdin.readLineSync()!;

          // Solicita o email do usuário ao usuário
          print("Digite o email do usuário:");
          String emailUsuario = stdin.readLineSync()!;

          // Chama o método cadastrarUsuario do serviço de biblioteca ( Instancia )
          biblioteca.cadastrarUsuario(idUsuario, nomeUsuario, emailUsuario);

          break;

        case '4':

          // Chama o método listarItens do serviço de biblioteca ( Instancia )
          biblioteca.listarItens();

          break;

        case '5':

          // Chama o método listarUsuarios do serviço de biblioteca ( Instancia )
          biblioteca.listarUsuarios();

          break;

        case '6':

          // Solicita o ID do usuário e do item a ser emprestado ao usuário
          print("Digite o ID do usuário:");
          int idUsuarioEmprestimo = int.parse(stdin.readLineSync()!);

          // Solicita o ID do item a ser emprestado ao usuário
          print("Digite o ID do item a ser emprestado:");
          int idItemEmprestimo = int.parse(stdin.readLineSync()!);

          // Chama o método realizarEmprestimo do serviço de biblioteca ( Instancia )
          biblioteca.realizarEmprestimo(idUsuarioEmprestimo, idItemEmprestimo);

          break;

        case '7':

          // Solicita o ID do item a ser devolvido ao usuário
          print("Digite o ID do item a ser devolvido:");
          int idItemDevolucao = int.parse(stdin.readLineSync()!);

          // Chama o método realizarDevolucao do serviço de biblioteca ( Instancia )
          biblioteca.realizarDevolucao(idItemDevolucao);

          break;

        case '8':

          //dar duas opções: buscar por título ou por categoria
          print("Escolha uma opção de busca:");
          print("1 - Buscar por título");
          print("2 - Buscar por categoria");

          // Solicita a opção de busca ao usuário
          String? opcaoBusca = stdin.readLineSync();

          // Chama o método buscarPorTitulo ou buscarPorCategoria do serviço de biblioteca ( Instancia ) com base na opção escolhida
          if (opcaoBusca == '1') {

            print("Digite o termo de busca:");
            String termoBusca = stdin.readLineSync()!;

            // Chama o método buscarPorTitulo do serviço de biblioteca ( Instancia )
            biblioteca.buscarPorTitulo(termoBusca);

          } else if (opcaoBusca == '2') {

            print("Digite a categoria de busca:");
            String categoriaBusca = stdin.readLineSync()!;

            // Chama o método buscarPorCategoria do serviço de biblioteca ( Instancia )
            biblioteca.buscarPorCategoria(categoriaBusca);

          } else {
            print("Opção inválida!");
          }
          break;

        case '9':

          // Chama o método relatorioBiblioteca do serviço de biblioteca ( Instancia )
          biblioteca.relatorioBiblioteca();

          break;

        case '0':

          print("Saindo do sistema...");
          return;
          
        default:
          print("Opção inválida! Tente novamente.");

    }
  }
}