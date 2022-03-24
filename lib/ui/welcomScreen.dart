import 'package:flutter/material.dart';

import 'loginScreen.dart';
import 'registerScreen.dart';
//import 'package:messageme_app/screens/registration_screen.dart';
//import 'package:messageme_app/screens/signin_screen.dart';
//import 'package:messageme_app/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffF6F6F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/image.png'),
                ),
                Text(
                  'ChatApp',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff72277A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          /*  MyButton(
              color: Colors.yellow[900]!,
              title: 'Sign in',
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute);
              },
            ),*/
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Material(
          elevation: 5,
          color: Colors.yellow[900]!,
          borderRadius: BorderRadius.circular(10),
          child: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginInScreen.screenRoute);
            },
            minWidth: 200,
            height: 42,
            child: Text(
              'Sign in',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Material(
                elevation: 5,
                color: Color(0xff72277A),
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.screenRoute);
                  },
                  minWidth: 200,
                  height: 42,
                  child: Text(
                    'register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          /*  MyButton(
              color: Colors.blue[800]!,
              title: 'register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
            )*/
          ],
        ),
      ),
    );
  }
}