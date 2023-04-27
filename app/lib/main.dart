import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sa3_liquid/liquid/plasma/plasma.dart';
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

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
      await FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
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
            builder: (BuildContext context, Widget? child) {
              return Stack(
                children: [
                  SizedBox.expand(
                    child: Container(
                      color: const Color(0xff1c1c1c),
                      child: const PlasmaRenderer(
                        type: PlasmaType.infinity,
                        particles: 9,
                        color: Color(0xddB71375),
                        blur: 0.9,
                        size: 0.6,
                        speed: 1,
                        offset: 0,
                        blendMode: BlendMode.screen,
                        particleType: ParticleType.atlas,
                        variation1: 0,
                        variation2: 0,
                        variation3: 0,
                        rotation: 0,
                        child: PlasmaRenderer(
                          type: PlasmaType.infinity,
                          particles: 4,
                          color: Color(0xdd8B1874),
                          blur: 1.5,
                          size: 0.6,
                          speed: 1,
                          offset: 0,
                          blendMode: BlendMode.screen,
                          particleType: ParticleType.atlas,
                          variation1: 0,
                          variation2: 0,
                          variation3: 0,
                          rotation: 0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox.expand(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/noise.png'),
                          fit: BoxFit.cover,
                          opacity: 0.1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox.expand(
                      child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0.8, 1],
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Color(0xcc1c1c1c),
                        ],
                      ),
                    ),
                  )),
                  child!,
                ],
              );
            },
            theme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: const ColorScheme.dark(),
              scaffoldBackgroundColor: Colors.transparent,
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(
                    displayLarge: const TextStyle(
                      fontFamily: 'Kumbh Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                    displayMedium: const TextStyle(
                      fontFamily: 'Kumbh Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    bodyMedium: const TextStyle(
                      fontFamily: 'Kumbh Sans',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                  .apply(
                      // bodyColor: Colors.white,
                      // displayColor: Colors.white,
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
