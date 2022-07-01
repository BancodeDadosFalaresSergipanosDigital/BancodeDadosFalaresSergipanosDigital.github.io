import 'package:falaressergipanosdigital/providers/user_provider.dart';
import 'package:falaressergipanosdigital/resources/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:falaressergipanosdigital/views/login/login.dart';
import 'package:falaressergipanosdigital/views/listarDados/listarDados.dart';
import 'package:falaressergipanosdigital/models/user.dart' as user_model;
import 'package:falaressergipanosdigital/views/notAprovated.dart';
import 'package:falaressergipanosdigital/views/waitingAprovation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDqTooWAE6kfyL5lkeoy7z7xQ7tMJNxtsk',
      appId: '1:807803778843:web:5c545f9547c5e632af85be',
      messagingSenderId: '807803778843',
      projectId: 'falaressergipanos-34263',
      storageBucket: 'falaressergipanos-34263.appspot.com',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Falares Sergipanos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  future: authMethods.getUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator()));
                    user_model.User user = snapshot.data as user_model.User;
                    if (user.approval_status == 1) return const WaitingAprovation();
                    if (user.approval_status == 2) return const NotAprovated();
                    return const ListarDados();
                  },
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
