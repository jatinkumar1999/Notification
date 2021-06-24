import 'package:authenticateuser/Card_Showing.dart';
import 'package:authenticateuser/FirebaseNotofications/FirstScreen.dart';
import 'package:authenticateuser/FirebaseNotofications/SecondScreen.dart';
import 'package:authenticateuser/views/Home.dart';
import 'package:authenticateuser/views/sevices/local_notifications.dart';
import 'package:authenticateuser/views/userdata.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// bacground notifitcation  when app is closed solution for onmessage
Future<void> backgroundMessaging(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessaging);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      routes: {
        "red": (context) => const FirstScreen(),
        "green": (context) => const SecondScreen(),
      },
    );
  }
}
