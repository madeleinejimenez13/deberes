import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil Flutter',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Perfil de Madeleine Jimenez'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Pantalla principal
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _buttonColorIndex = 0;

  final List<Color> _buttonColors = [
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
    Colors.orange,
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _navigateToSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondPage()),
    );
  }

  void _changeButtonColor() {
    setState(() {
      _buttonColorIndex = (_buttonColorIndex + 1) % _buttonColors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FF),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFFBDA8F3),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.network(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  child: Column(
                    children: const [
                      Text(
                        'Madeleine Jimenez Gaona',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Ingeniera de la Tecnología',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Contador de clics:',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.deepPurple),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _changeButtonColor();
                  _navigateToSecondPage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _buttonColors[_buttonColorIndex],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.arrow_forward_ios),
                label: const Text("Ir a más detalles"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: const Color(0xFF9B89F9),
        tooltip: 'Incrementar contador',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Segunda pantalla con botones que cambian de color
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<String> _elementos = [];
  int _contadorLista = 1;
  int _addBtnColorIndex = 0;
  int _backBtnColorIndex = 0;

  final List<Color> _buttonColors = [
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
    Colors.orange,
  ];

  void _agregarElemento() {
    setState(() {
      _elementos.add('Elemento $_contadorLista');
      _contadorLista++;
      _addBtnColorIndex = (_addBtnColorIndex + 1) % _buttonColors.length;
    });
  }

  void _eliminarElemento(int index) {
    setState(() {
      _elementos.removeAt(index);
    });
  }

  void _volver() {
    setState(() {
      _backBtnColorIndex = (_backBtnColorIndex + 1) % _buttonColors.length;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A9BFF),
        foregroundColor: Colors.white,
        title: const Text('Detalles adicionales'),
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Text(
              '¡Hola desde la segunda pantalla!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                width: 220,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lista dinámica de elementos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _elementos.isEmpty
                  ? const Center(child: Text("No hay elementos aún"))
                  : ListView.builder(
                      itemCount: _elementos.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(_elementos[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _eliminarElemento(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _agregarElemento,
              icon: const Icon(Icons.add),
              label: const Text('Agregar elemento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _buttonColors[_addBtnColorIndex],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _volver,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _buttonColors[_backBtnColorIndex],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
