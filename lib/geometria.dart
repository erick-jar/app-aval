import 'dart:math';
import 'package:flutter/material.dart';

class Geometria extends StatefulWidget {
  const Geometria({super.key});

  @override
  State<Geometria> createState() => _GeometriaState();
}

class _GeometriaState extends State<Geometria> {
  // Controladores para os inputs
  final TextEditingController _controllerInput1 = TextEditingController();
  final TextEditingController _controllerInput2 = TextEditingController();
  final TextEditingController _controllerInput3 = TextEditingController();

  String _figuraSelecionada = 'Quadrado';
  String _resultado = "Área: ";

  // Lista com as figuras planas suportadas
  final List<String> _figuras = [
    'Quadrado',
    'Retângulo',
    'Triângulo',
    'Círculo',
    'Trapézio',
    'Losango'
  ];

  void _calcularArea() {
    final double? val1 = double.tryParse(_controllerInput1.text);
    final double? val2 = double.tryParse(_controllerInput2.text);
    final double? val3 = double.tryParse(_controllerInput3.text);

    double area = 0;

    // Validação dependendo da figura escolhida
    if (_figuraSelecionada == 'Quadrado' && val1 != null) {
      area = val1 * val1;
    } else if (_figuraSelecionada == 'Retângulo' && val1 != null && val2 != null) {
      area = val1 * val2;
    } else if (_figuraSelecionada == 'Triângulo' && val1 != null && val2 != null) {
      area = (val1 * val2) / 2;
    } else if (_figuraSelecionada == 'Círculo' && val1 != null) {
      area = pi * pow(val1, 2); // pi vem da biblioteca dart:math
    } else if (_figuraSelecionada == 'Trapézio' && val1 != null && val2 != null && val3 != null) {
      area = ((val1 + val2) * val3) / 2;
    } else if (_figuraSelecionada == 'Losango' && val1 != null && val2 != null) {
      area = (val1 * val2) / 2;
    } else {
      setState(() {
        _resultado = "Por favor, preencha os campos corretamente.";
      });
      return;
    }

    setState(() {
      _resultado = "Área: ${area.toStringAsFixed(2)}";
    });
  }

  // Limpa os campos sempre que trocar de figura geométrica
  void _limparCampos() {
    _controllerInput1.clear();
    _controllerInput2.clear();
    _controllerInput3.clear();
    setState(() {
      _resultado = "Área: ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Área de Figuras Planas'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dropdown para selecionar a figura
            const Text(
              "Selecione a figura geométrica:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _figuraSelecionada,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _figuras.map((String figura) {
                return DropdownMenuItem<String>(
                  value: figura,
                  child: Text(figura),
                );
              }).toList(),
              onChanged: (novoValor) {
                setState(() {
                  _figuraSelecionada = novoValor!;
                  _limparCampos();
                });
              },
            ),
            const SizedBox(height: 24),

            // Renderização dinâmica dos campos de texto baseada na escolha do usuário
            if (_figuraSelecionada == 'Quadrado') ...[
              _buildTextField(_controllerInput1, 'Lado do quadrado'),
            ] else if (_figuraSelecionada == 'Retângulo') ...[
              _buildTextField(_controllerInput1, 'Base (Largura)'),
              const SizedBox(height: 16),
              _buildTextField(_controllerInput2, 'Altura (Comprimento)'),
            ] else if (_figuraSelecionada == 'Triângulo') ...[
              _buildTextField(_controllerInput1, 'Base'),
              const SizedBox(height: 16),
              _buildTextField(_controllerInput2, 'Altura'),
            ] else if (_figuraSelecionada == 'Círculo') ...[
              _buildTextField(_controllerInput1, 'Raio do círculo'),
            ] else if (_figuraSelecionada == 'Trapézio') ...[
              _buildTextField(_controllerInput1, 'Base Maior'),
              const SizedBox(height: 16),
              _buildTextField(_controllerInput2, 'Base Menor'),
              const SizedBox(height: 16),
              _buildTextField(_controllerInput3, 'Altura'),
            ] else if (_figuraSelecionada == 'Losango') ...[
              _buildTextField(_controllerInput1, 'Diagonal Maior'),
              const SizedBox(height: 16),
              _buildTextField(_controllerInput2, 'Diagonal Menor'),
            ],

            const SizedBox(height: 24),

            // Botão Calcular
            ElevatedButton(
              onPressed: _calcularArea,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical:14),
              ),
              child: const Text('Calcular Área', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 32),

            // Resultado
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para economizar código na criação de inputs repetidos
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
