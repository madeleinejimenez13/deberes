import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Instancia para notificaciones locales
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Handler para notificaciones recibidas en background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  RemoteNotification? notification = message.notification;
  if (notification != null) {
    _showLocalNotification(notification.title ?? '', notification.body ?? '');
  }
}

// Función para mostrar notificaciones locales
void _showLocalNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'Canal de Notificaciones',
    channelDescription: 'Canal para notificaciones locales y push',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Inicializar notificaciones locales
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() async {
    messaging = FirebaseMessaging.instance;

    // Solicitar permisos para notificaciones (iOS/Android 13+)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await messaging.getToken();
      print('🔐 FCM Token: $token');
    } else {
      print('Permiso de notificaciones denegado');
    }

    // Escuchar notificaciones cuando app está en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        _showLocalNotification(notification.title ?? '', notification.body ?? '');
      }
    });

    // Cuando se abre la app desde una notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Notificación abierta!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Notificaciones',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Notificaciones Locales y Push')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _showLocalNotification(
                'Notificación local',
                'Esta es una notificación local generada desde la app.',
              );
            },
            child: const Text('Mostrar Notificación Local'),
          ),
        ),
      ),
    );
  }
}
