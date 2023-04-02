import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/screens/onboarding_screen.dart';
import 'package:workspaces/services/auth_service.dart';
import 'package:workspaces/screens/home_screen.dart';
import 'package:workspaces/services/firestore_service.dart';
import 'package:workspaces/services/hot_user_proxy.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: const AuthGate(),
        ),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    var firebaseUser = context.watch<User?>();
    var hotUser = context.watch<HotUser?>();
    if (firebaseUser == null) {
      if (FirebaseAuth.instance.currentUser == null) {
        context.read<AuthService>().signInAnonymously();
      }
      return const Text("splash");
    }

    if (hotUser == null) {
      return const Text("loading your profile...");
    }

    if (hotUser.sessionsPerWeekGoal == null) {
      return const OnboardingScreen();
    }

    return const HomeScreen();
  }
}
