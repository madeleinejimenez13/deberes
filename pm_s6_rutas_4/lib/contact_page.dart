import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactoPage({super.key});

@override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Contactos'),),
      body: Center(child: Text('Pantalla de contacto'),),
    );
  }
}
