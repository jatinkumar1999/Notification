import 'package:authenticateuser/views/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Facebook,
              onPressed: () async {
                await signInWithFacebook()
                    .then(
                  (user) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => UserData(
                        user: user,
                      ),
                    ),
                  ),
                )
                    .catchError((e) {
                  print(e);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
