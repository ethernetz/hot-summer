import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/providers/auth_provider.dart';
import 'package:workspaces/screens/chat_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:workspaces/screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => AuthProvider(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (BuildContext context) {
              return context.read<AuthProvider>().authStateChanges;
            },
            initialData: null,
          )
        ],
        child: MaterialApp(
          title: 'Hot Summer',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseUser = context.watch<User?>();
    // print('user is');
    // print(firebaseUser);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apple Sign Inn'),
      ),
      body: firebaseUser == null ? const AuthScreen() : const ChatScreen(),
    );
  }
}
