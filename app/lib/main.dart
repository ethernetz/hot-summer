import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/services/auth_service.dart';
import 'package:workspaces/screens/home_screen.dart';
import 'package:workspaces/services/firestore_service.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:workspaces/screens/auth_screen.dart';
import 'package:workspaces/classes/hot_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator("firebase", 8080);
      await FirebaseAuth.instance.useAuthEmulator("firebase", 9099);
    } catch (exception) {
      print(exception);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(
            create: (ctx) => AuthService(FirebaseAuth.instance),
          ),
          Provider(
            create: (ctx) => FirestoreService(FirebaseFirestore.instance),
          ),
          StreamProvider<User?>(
            create: (BuildContext context) {
              return context.read<AuthService>().authStateChanges;
            },
            initialData: null,
          ),
        ],
        child: HotUserProxy(
          child: MaterialApp(
            home: const Home(),
            theme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: const ColorScheme.dark(
                  // primary: Colors.red,
                  // secondary: Colors.blue,
                  // background: Colors.black,
                  ),
              scaffoldBackgroundColor: Colors.black,
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
          ),
        ));
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseUser = context.watch<User?>();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: firebaseUser == null ? const AuthScreen() : const HomeScreen(),
        ),
      ),
    );
  }
}

class HotUserProxy extends StatefulWidget {
  final Widget? child;

  const HotUserProxy({super.key, this.child});

  @override
  State<HotUserProxy> createState() => _HotUserProxyState();
}

class _HotUserProxyState extends State<HotUserProxy> {
  Stream<HotUser?> _hotUserStream = const Stream.empty();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var firebaseUser = context.watch<User?>();
    _hotUserStream = getUserStream(firebaseUser);
  }

  Stream<HotUser?> getUserStream(User? firebaseUser) {
    if (firebaseUser == null) {
      return const Stream.empty();
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .snapshots()
        .map((userDocumentSnapshot) {
      final userData = userDocumentSnapshot.data();
      if (userData == null) {
        return null;
      }
      return HotUser.fromJson(userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<HotUser?>.value(
      value: _hotUserStream,
      initialData: null,
      child: widget.child,
    );
  }
}
