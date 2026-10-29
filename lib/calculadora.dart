import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  // Controladores para capturar o texto dos inputs
  final TextEditingController _controllerValor1 = TextEditingController();
  final TextEditingController _controllerValor2 = TextEditingController();

  String _resultado = "Resultado: ";

  // Função genérica para realizar as operações matemáticas
  void _calcular(String operacao) {
    // Tenta converter o texto para número, se falhar ou estiver vazio vira null
    final double? num1 = double.tryParse(_controllerValor1.text);
    final double? num2 = double.tryParse(_controllerValor2.text);

    // Validação caso o usuário digite algo inválido ou deixe vazio
    if (num1 == null || num2 == null) {
      setState(() {
        _resultado = "Por favor, insira números válidos.";
      });
      return;
    }

    double calculo = 0;

    switch (operacao) {
      case 'multiplicar':
        calculo = num1 * num2;
        break;
      case 'subtrair':
        calculo = num1 - num2;
        break;
      case 'dividir':
        if (num2 == 0) {
          setState(() {
            _resultado = "Erro: Divisão por zero não permitida.";
          });
          return;
        }
        calculo = num1 / num2;
        break;
    }

    // Atualiza a tela com o resultado formatado
    setState(() {
      // Remove o .0 se o número for inteiro para ficar mais limpo
      _resultado = "Resultado: ${calculo % 1 == 0 ? calculo.toInt() : calculo}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Simples'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo do Primeiro Valor
            TextField(
              controller: _controllerValor1,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite o primeiro valor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Campo do Segundo Valor
            TextField(
              controller: _controllerValor2,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite o segundo valor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Linha com os botões de ação
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _calcular('multiplicar'),
                    child: const Text('Multiplicar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _calcular('subtrair'),
                    child: const Text('Subtrair'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _calcular('dividir'),
                    child: const Text('Dividir'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Exibição do Resultado
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
