import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/screens/auth_screen.dart';
import 'package:workspaces/screens/home_screen.dart';
import 'package:workspaces/services/auth_service.dart';
import 'package:workspaces/services/current_workout_provider.dart';
import 'package:workspaces/services/firestore_service.dart';
import 'package:workspaces/services/hot_user_proxy.dart';
import 'package:workspaces/services/workouts_proxy.dart';
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

  if (kDebugMode || kProfileMode) {
    try {
      FirebaseFirestore.instance.settings =
          const Settings(persistenceEnabled: false);
      FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
      FirebaseAuth.instance.signOut();
      // FirebaseFirestore.instance.clearPersistence();
      await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
    } catch (exception) {
      if (kDebugMode) print(exception);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
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
        ChangeNotifierProvider(
          create: (ctx) => CurrentWorkoutProvider(),
        ),
      ],
      child: HotUserProxy(
        child: WorkoutsProxy(
          child: CupertinoTheme(
            data: const CupertinoThemeData(
              primaryColor: CupertinoColors.activeBlue,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  color: CupertinoColors.white,
                ),
              ),
              brightness: Brightness.dark,
            ),
            child: MaterialApp(
              initialRoute: '/',
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case '/':
                    return AuthScreen.route();
                  case '/home':
                    return HomeScreen.route();
                  default:
                    throw Exception('Invalid route: ${settings.name}');
                }
              },
              theme: ThemeData(
                brightness: Brightness.dark,
                colorScheme: const ColorScheme.dark().copyWith(
                  primary: const Color(0xfffff21a),
                  primaryContainer: const Color(0xff292C2D),
                ),
                scaffoldBackgroundColor: const Color(0xff000000),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
