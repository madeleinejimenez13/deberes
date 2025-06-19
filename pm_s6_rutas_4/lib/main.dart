import 'package:flutter/material.dart';

void _goToPageCoontac(BuildContext context){ 
  Navigator.of(context).push(
    MaterialPageRoute(bulder: (_)=> ContactPage()),
  );
}
class ContactPage extends StatelessWidget {
  const ContactoPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio'),
      ),
      drawer: Drawer(
        child: [
          DrawerHeader(
            decoration: BoxDecoration: (color: Colors.blue),
            child: Text{
            'Menu'
            style; TextStyle(color: Colors.)  
            })
        ],
      )
    body: Center{
      child: ElevatedButton(onPressed: () =>  _goToPageCoontac(), child: Text('Ir a contacto'),)
    },
    );
  }
}