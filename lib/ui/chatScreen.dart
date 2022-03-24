import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
late User signedInUser;
final _auth = FirebaseAuth.instance;
final currentUser = signedInUser.email;
class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _fireStore = FirebaseFirestore.instance;
  String? text;
  TextEditingController controller= TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatApp'),
        backgroundColor: Color(0xff72277A),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _fireStore.collection('messages').orderBy('time').snapshots(),
                builder: (context, snapshot) => snapshot.hasData

                    ?
                Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            print("curr ${_auth.currentUser!.email}");
                            print('dd ${snapshot.data!.docs[index]['sender']}');
                          if(_auth.currentUser!.email==snapshot.data!.docs[index]['sender']){

                            return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(snapshot.data!.docs[index]['sender'],
                                    style: TextStyle(
                                       color: Colors.grey
                                    )),

                                Material(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft:Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                      topLeft:Radius.circular(30) ,
                                    ),
                                    color: Colors.orange,
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        snapshot.data!.docs[index]['text'],
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    )),
                              ],
                            ),
                          );}else{
                           return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data!.docs[index]['sender'],
                                      style: TextStyle(
                                          color: Colors.grey
                                      )),

                                  Material(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft:Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                        topRight:Radius.circular(30) ,
                                      ),
                                      color:  Color(0xff72277A),
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Text(
                                          snapshot.data!.docs[index]['text'],
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.white),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }return Container();}
                        ),
                      )
                    : Container(child: const Text('no data'))),


            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        text = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.clear();
                      _fireStore.collection('messages').add({
                        'text': text,
                        'sender': signedInUser.email,
                        'time':FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Color(0xff72277A),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
