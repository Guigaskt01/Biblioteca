class Usuario {
  int id;
  String nome;
  String email;
  int _quantidadeEmprestimos = 0;

  //Construtor
  Usuario(this.id, this.nome, this.email);

  //Regra de negócio 4

  void adicionarEmprestimo() {
    //O objetivo desta function é adicionar emprestimo ao usuário
    //regras de negócio: Não pode estar acima de 3 empréstimos


    if (_quantidadeEmprestimos < 3) {
        _quantidadeEmprestimos ++;
      } 
    else {
      print("Você atingiu o limite de empréstimos!");
    }

  }

  void removerEmprestimo() {
    //Objetivo da function: Remover Emprestimos caso tenha

    if (_quantidadeEmprestimos > 0) { 
        _quantidadeEmprestimos--;
    } 
    else {
      print("Não existe empréstimos para remover");}
    }

  //Forma abreviada de verificar quantidade
  int get quantidadeEmprestimos {
    return _quantidadeEmprestimos;
  }
}