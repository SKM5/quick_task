import 'package:flutter/material.dart';
import 'package:quick_task/screens/login_screen.dart';
import 'services/back4app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeBack4App();  // Initialize Back4App
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickTask',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: LoginScreen(),
    );
  }
}

