// lib/widgets/user_form.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserForm extends StatefulWidget {
  final Function(User) onSubmit;

  const UserForm({super.key, required this.onSubmit});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              key: const Key('nameField'), // Agrega esta clave
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              key: const Key('jobField'), // Agrega esta clave
              controller: _jobController,
              decoration: const InputDecoration(
                labelText: 'Trabajo',
                border: OutlineInputBorder(),
              ),
              // Job es opcional, así que no validamos
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email (opcional)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final user = User(
                      name: _nameController.text.trim(),
                      job: _jobController.text.trim().isNotEmpty ? _jobController.text.trim() : null,
                      email: _emailController.text.trim().isNotEmpty ? _emailController.text.trim() : null,
                    );
                    widget.onSubmit(user);
                    _nameController.clear();
                    _jobController.clear();
                    _emailController.clear();
                  }
                },
                child: const Text('Crear Usuario'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}