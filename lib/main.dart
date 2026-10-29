import 'package:flutter/material.dart';
import 'calculadora.dart';
import 'geometria.dart';
import 'velocidade.dart'; // Importa o novo arquivo de velocidade

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const NavegacaoAbas(),
    );
  }
}

class NavegacaoAbas extends StatefulWidget {
  const NavegacaoAbas({super.key});

  @override
  State<NavegacaoAbas> createState() => _NavegacaoAbasState();
}

class _NavegacaoAbasState extends State<NavegacaoAbas> {
  int _abaAtual = 0;

  // Lista com as três telas criadas em arquivos separados
  final List<Widget> _telas = [
    const Calculadora(),
    const Geometria(),
    const Velocidade(), // Inserida aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_abaAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaAtual,
        type: BottomNavigationBarType.fixed, // Garante bom comportamento com 3+ itens
        onTap: (index) {
          setState(() {
            _abaAtual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculadora',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_history),
            label: 'Geometria',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.speed), // Ícone de velocímetro para a nova aba
            label: 'Velocidade',
          ),
        ],
      ),
    );
  }
}
