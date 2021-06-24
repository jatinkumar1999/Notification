import 'package:authenticateuser/views/Home.dart';
import 'package:authenticateuser/views/sevices/local_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class UserData extends StatefulWidget {
  final UserCredential user;
  UserData({
    @required this.user,
    Key key,
  });

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final dynamic userData = "";

  Future<void> signout() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user.providerData[0].providerId == 'facebook.com') {
      await FacebookAuth.instance.logOut();
    }
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final firebaseData = message.data["route"];
        print(firebaseData);
        Navigator.of(context).pushNamed(firebaseData);
      }
    });
    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.body);
        print(message.notification.title);
      }
      LocalNotificationService.display(message);
    });
    //app should be in background but not closed
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final firebaseData = message.data["route"];
      print(firebaseData);
      Navigator.of(context).pushNamed(firebaseData);
    });

    //for closed App
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(widget.user.user.photoURL)),
              const SizedBox(height: 10),
              Text(
                widget.user.user.displayName,
              ),
              const SizedBox(height: 10),
              Text(
                widget.user.user.uid,
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.amber,
                onPressed: () {
                  signout().then(
                    (value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    ),
                  );
                },
                child: const Text("SignOut"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
