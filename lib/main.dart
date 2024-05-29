import 'package:adalato_app/screens/login/login_screen.dart';
import 'package:adalato_app/utils/app_router.dart';
import 'package:adalato_app/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCEkGYy5SV2pz61rplXJjHcYUV60jc9K5k",
      authDomain: "adalato-app.firebaseapp.com",
      projectId: "adalato-app",
      storageBucket: "adalato-3c4bc.appspot.com",
      messagingSenderId: "72936713042",
      appId: "1:72936713042:android:377d68b2a74d933385a88b",
    ),
  );

  User? user = FirebaseAuth.instance.currentUser;
  String initialRoute;
  String? message;

  if (user == null) {
    initialRoute = AppRoutes.start;
  } else if (!user.emailVerified) {
    await FirebaseAuth.instance.signOut();
    initialRoute = AppRoutes.login;
    message = "Please verify your email before logging in.";
  } else {
    initialRoute = AppRoutes.home;
  }

  runApp(AdalatoGymApp(initialRoute: initialRoute, message: message));
}

class AdalatoGymApp extends StatelessWidget {
  final String initialRoute;
  final String? message;

  const AdalatoGymApp({Key? key, required this.initialRoute, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adalato Gym App',
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.login) {
          return MaterialPageRoute(
            builder: (context) => LoginPage(),
          );
        }
        return AppRouter.generateRoute(settings);
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}