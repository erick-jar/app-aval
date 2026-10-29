import 'package:flutter/material.dart';

class Velocidade extends StatefulWidget {
  const Velocidade({super.key});

  @override
  State<Velocidade> createState() => _VelocidadeState();
}

class _VelocidadeState extends State<Velocidade> {
  // Controladores para capturar distância e tempo
  final TextEditingController _controllerDistancia = TextEditingController();
  final TextEditingController _controllerTempo = TextEditingController();

  String _unidadeSelecionada = 'km e horas (Resultado em km/h)';
  String _resultado = "Velocidade: ";

  final List<String> _unidades = [
    'km e horas (Resultado em km/h)',
    'metros e segundos (Resultado em m/s)',
  ];

  void _calcularVelocidade() {
    final double? distancia = double.tryParse(_controllerDistancia.text);
    final double? tempo = double.tryParse(_controllerTempo.text);

    // Validação de campos vazios ou inválidos
    if (distancia == null || tempo == null) {
      setState(() {
        _resultado = "Por favor, preencha os valores corretamente.";
      });
      return;
    }

    // Validação para evitar divisão por zero
    if (tempo == 0) {
      setState(() {
        _resultado = "O tempo não pode ser igual a zero.";
      });
      return;
    }

    // Cálculo da velocidade média
    double velocidade = distancia / tempo;
    String sufixoUnidade = _unidadeSelecionada.contains('km/h') ? 'km/h' : 'm/s';

    setState(() {
      _resultado = "Velocidade Média: ${velocidade.toStringAsFixed(2)} $sufixoUnidade";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Velocidade'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown para escolher a unidade de medida
            const Text(
              "Escolha o sistema de unidades:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _unidadeSelecionada,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _unidades.map((String unidade) {
                return DropdownMenuItem<String>(
                  value: unidade,
                  child: Text(unidade, style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              onChanged: (novoValor) {
                setState(() {
                  _unidadeSelecionada = novoValor!;
                });
              },
            ),
            const SizedBox(height: 24),

            // Input da Distância
            TextField(
              controller: _controllerDistancia,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: _unidadeSelecionada.contains('km/h') 
                    ? 'Distância percorrida (em km)' 
                    : 'Distância percorrida (em metros)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Input do Tempo
            TextField(
              controller: _controllerTempo,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: _unidadeSelecionada.contains('km/h') 
                    ? 'Tempo gasto (em horas)' 
                    : 'Tempo gasto (em segundos)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Botão Calcular
            ElevatedButton(
              onPressed: _calcularVelocidade,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical:14),
              ),
              child: const Text('Calcular Velocidade', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 32),

            // Exibição do Resultado
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
