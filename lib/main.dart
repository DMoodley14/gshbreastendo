import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gshbreastendo/pages.dart';
//import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appTitle = 'Home';
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("error");
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            print("sign in");
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return MaterialApp(
            color: Colors.white,
            debugShowCheckedModeBanner: false,
            home: AnimatedSplashScreen(
              splash: 'assets/white1.jpg',
              nextScreen: MyHomePage(),
              splashTransition: SplashTransition.rotationTransition,
              duration: 2500,
            ),
          );
        });
  }
}
