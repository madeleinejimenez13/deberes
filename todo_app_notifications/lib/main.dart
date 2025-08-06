import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// Función que se ejecuta cuando llega una notificación en segundo plano
Future<void> _backgroundHandler(RemoteMessage message) async {
  print("ON BACKGROUND: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Pedir permisos
  await FirebaseMessaging.instance.requestPermission();

  // Obtener token FCM (¡IMPORTANTE!)
  String? token = await FirebaseMessaging.instance.getToken();
  print("TOKEN FCM: $token"); // Cópialo cuando veas esto en consola

  // Configurar handlers
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  FirebaseMessaging.onMessage.listen((message) {
    print("ON FOREGROUND: ${message.notification?.title}");
    ScaffoldMessenger.of(mainKey.currentState!.context).showSnackBar(
      SnackBar(content: Text("📢 ${message.notification?.title}")),
    );
  });

  runApp(MyApp());
}

final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notificaciones',
      navigatorKey: mainKey,
      home: NotificacionesScreen(),
    );
  }
}

class NotificacionesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notificaciones")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("App lista para recibir notificaciones", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Esta app SOLO RECIBE notificaciones
                // Las enviamos desde Firebase Console
              },
              child: Text("Esperando notificaciones..."),
            ),
          ],
        ),
      ),
    );
  }
}