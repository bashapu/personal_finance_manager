import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'home.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'finance_app.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, email TEXT, password TEXT, is_guest INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> _login(BuildContext context) async {
    if (_database == null) return;

    List<Map<String, dynamic>> users = await _database!.query(
      'users',
      where: "email = ? AND password = ?",
      whereArgs: [_emailController.text, _passwordController.text],
    );

    if (users.isNotEmpty) {
      if (mounted) {
        _navigateToHome(context, users.first['id']);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Invalid credentials')));
      }
    }
  }

  Future<void> _register(BuildContext context) async {
    if (_database == null) return;

    String userId = Uuid().v4();
    await _database!.insert('users', {
      'id': userId,
      'email': _emailController.text,
      'password': _passwordController.text,
      'is_guest': 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    if (mounted) {
      _navigateToHome(context, userId);
    }
  }

  Future<void> _continueAsGuest(BuildContext context) async {
    if (_database == null) return;

    String guestId = Uuid().v4();
    await _database!.insert('users', {
      'id': guestId,
      'email': 'guest',
      'password': '',
      'is_guest': 1,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    if (mounted) {
      _navigateToHome(context, guestId);
    }
  }

  void _navigateToHome(BuildContext context, String userId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _login(context), child: Text('Login')),
            ElevatedButton(onPressed: () => _register(context), child: Text('Register')),
            ElevatedButton(onPressed: () => _continueAsGuest(context), child: Text('Continue as Guest')),
          ],
        ),
      ),
    );
  }
}
