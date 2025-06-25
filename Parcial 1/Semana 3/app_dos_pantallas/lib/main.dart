import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 200, 181, 235),
        ),
        textTheme: GoogleFonts.latoTextTheme(),
        scaffoldBackgroundColor: Colors.grey[100],
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final List<Widget> _pages = [
    const PerfilPage(),
    const AcercaPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 162, 211, 237)),
              child: Text('Menú Lateral', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Acerca de mí'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Acerca'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar contador',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterText = (context.findAncestorStateOfType<_MyHomePageState>()?._counter ?? 0).toString();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Stack decorativo
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1503264116251-35a269479413'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  'Bienvenida, Madeleine',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    shadows: const [Shadow(blurRadius: 6, color: Colors.black87)],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Información personal (Column)
          Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: const NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
              ),
              const SizedBox(height: 12),
              Text('Madeleine Jimenez Gaona',
                  style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('Ingeniera de la Tecnología', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 20),

          // Información de contacto (Row)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.email, color: Colors.blue),
              SizedBox(width: 8),
              Text('majimenezgao@uide.edu.ec', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 20),

          // Contador
          Column(
            children: [
              const Text('Contador de clicks:', style: TextStyle(fontSize: 16)),
              Text(
                counterText,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondPage()),
              );
            },
            child: const Text("Ir a segunda pantalla"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class AcercaPage extends StatelessWidget {
  const AcercaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Esta es la sección de información adicional sobre Madeleine. '
          'Aquí podrías incluir datos personales, intereses, logros o proyectos.',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 7, 119, 255),
          title: const Text('Detalles adicionales'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Mensaje'),
              Tab(text: 'Imagen'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '¡Hola desde la segunda pantalla!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: Image(
                image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                width: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
