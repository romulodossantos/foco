// Classe que representa uma tarefa
class Task {
  // Título da tarefa
  String title;

  // Status da tarefa: pode ser 'pendente', 'em progresso' ou 'concluida'
  String status;

  // Construtor da classe, exige o título e atribui 'pendente' como status padrão
  Task({required this.title, this.status = 'pendente'});

  // Factory constructor para criar uma instância de Task a partir de um JSON (Map)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],   // Obtém o título do mapa JSON
      status: json['status'], // Obtém o status do mapa JSON
    );
  }

  // Método que converte a instância de Task em um Map JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'status': status,
    };
  }
}
