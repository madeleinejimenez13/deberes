// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/user_list.dart';
import 'widgets/user_form.dart';
import 'services/api_service.dart';
import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UIDE - API REST',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<User> users = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      users.clear();
    });

    try {
      final fetchedUsers = await _apiService.getUsers();
      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } on Exception catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _createUser(User user) async {
    try {
      final newUser = await _apiService.createUser(user);
      setState(() {
        users.insert(0, newUser);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Usuario creado con éxito')),
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UIDE - API REST'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers,
            tooltip: 'Recargar datos',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: UserList(
              users: users,
              isLoading: isLoading,
              error: errorMessage,
              onRetry: _loadUsers,
            ),
          ),
          const Divider(height: 1),
          UserForm(onSubmit: _createUser),
        ],
      ),
    );
  }
}