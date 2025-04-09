import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import 'dashboard_screen.dart';
import '../services/session_manager.dart';
import '../models/user.dart';
import 'package:uuid/uuid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  void _register(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final user = AppUser(
        id: Uuid().v4(),
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      final db = await DatabaseHelper.instance.database;
      await db.insert('users', user.toMap());
      SessionManager().loginUser(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: "Full Name"),
                controller: _nameController,
                validator: FormBuilderValidators.required(),
              ),
              // TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Full Name')),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: "Email"),
                controller: _emailController,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              // ßTextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: "Password"),
                controller: _passwordController,
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(
                    6,
                    errorText: 'Password must be at least 6 characters',
                  ),
                ]),
              ),
              // TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password',), obscureText: true,),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _register(context),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}