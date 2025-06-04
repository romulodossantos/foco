// Importa pacotes essenciais do Flutter e o pacote para gráfico de pizza
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

// Importa o modelo Task para manipular os dados das tarefas
import 'task_model.dart';

// Widget imutável que representa a tela de progresso das tarefas
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  // Método privado que calcula a quantidade de tarefas em cada status
  Map<String, double> _calculateProgress(List<Task> tasks) {
    int concluida = 0;
    int pendente = 0;
    int progresso = 0;

    // Itera sobre a lista de tarefas para contar o status de cada uma
    for (var task in tasks) {
      if (task.status == 'concluida') {
        concluida++;       // Incrementa contador para tarefas concluídas
      } else if (task.status == 'pendente') {
        pendente++;       // Incrementa contador para tarefas pendentes
      } else {
        progresso++;      // Incrementa para tarefas em progresso (ou outros status)
      }
    }

    // Retorna um mapa com as categorias e seus respectivos valores convertidos para double
    return {
      'Concluída': concluida.toDouble(),
      'Pendente': pendente.toDouble(),
      'Em Progresso': progresso.toDouble(),
    };
  }

  @override
  Widget build(BuildContext context) {
    // Obtém a lista de tarefas passada via argumento na navegação de rotas
    final tasks = ModalRoute.of(context)!.settings.arguments as List<Task>;

    // Calcula os dados para o gráfico a partir das tarefas
    final dataMap = _calculateProgress(tasks);

    // Estrutura visual da tela
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progresso das Tarefas'), // Título da barra superior
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Espaçamento interno
          child: PieChart(
            dataMap: dataMap, // Dados que alimentam o gráfico
            chartRadius: MediaQuery.of(context).size.width / 2, // Tamanho do gráfico proporcional à largura da tela
            chartType: ChartType.ring, // Tipo do gráfico: anel
            ringStrokeWidth: 30, // Espessura do anel
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true, // Mostra os valores em porcentagem
              showChartValueBackground: false, // Sem fundo nos valores
              decimalPlaces: 0, // Sem casas decimais
            ),
            legendOptions: const LegendOptions(
              legendPosition: LegendPosition.bottom, // Legenda posicionada na parte inferior
              showLegendsInRow: true, // Exibe as legendas em linha horizontal
            ),
          ),
        ),
      ),
    );
  }
}

