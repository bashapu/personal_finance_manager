import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import 'register_screen.dart';
import 'dashboard_screen.dart';
import '../models/user.dart';
import '../services/session_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  void _continueAsGuest(BuildContext context) {
    final guestUser = AppUser(id: Uuid().v4(), name: "Guest", email: "", password: "");
    SessionManager().loginUser(guestUser);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => DashboardScreen()),
    );
  }

  void _login(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final db = await DatabaseHelper.instance.database;
      final users = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [_emailController.text, _passwordController.text],
      );
      if (users.isNotEmpty) {
        final user = AppUser.fromMap(users.first);
        SessionManager().loginUser(user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DashboardScreen()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid credentials")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilderTextField(
                name: 'email',
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              FormBuilderTextField(
                name: 'password',
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(
                    6,
                    errorText: 'Password must be at least 6 characters',
                  ),
                ]),
              ),
              //TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
              // TextField(
              //   controller: _passwordController,
              //   decoration: InputDecoration(labelText: 'Password'),
              //   obscureText: true,
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Login'),
              ),
              TextButton(
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()),
                    ),
                child: Text('Register'),
              ),
              TextButton(
                onPressed: () => _continueAsGuest(context),
                child: Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}