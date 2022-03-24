import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_new_project/ui/chatScreen.dart';
import 'package:flutter/material.dart';

import 'ui/loginScreen.dart';
import 'ui/registerScreen.dart';
import 'ui/welcomScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: WelcomeScreen.screenRoute,
        routes: {
          WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
          LoginInScreen.screenRoute: (context) => LoginInScreen(),
          RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
          ChatScreen.screenRoute: (context) => ChatScreen(),
        }
        );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    await firebase.collection('note').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("firebase"),
      ),
      body: //Container(),
     StreamBuilder<QuerySnapshot>(
          stream: firebase.collection('note').snapshots(),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Expanded(
                    child: ListView(
                      shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Text(snapshot.data!.docs[index]['name']),
                            Text(snapshot.data!.docs[index]['phone']),
                          ],
                        ),
                  ))
              : Container(child: const Text('no data'))),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
