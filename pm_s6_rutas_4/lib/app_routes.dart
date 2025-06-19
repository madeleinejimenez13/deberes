import 'package:flutter/material.dart';

class AppRoutes {
  static const String login= '/login';
  static const String home= '/home';
  static const String settings= '/settings';
  static const String contact= '/contact';


  static Route<dynamic> generateRouter(RouterSettings settings){
    switch(settings.name){
      case AppRoutes.login:
      return MaterialPageRoute(builder: (context)=> Scaffold(
        body: Center(child: Text(Ruta no encontrada),),
      ))
    }
  }
}