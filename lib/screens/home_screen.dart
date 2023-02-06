import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scorpion_plus/api/apis.dart';
import 'package:scorpion_plus/main.dart';
import 'package:scorpion_plus/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
        leading: Icon(CupertinoIcons.home),
        title: Text('Scorpion+'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: Icon(Icons.add_comment_rounded),
        ),
      ),
      body: ListView.builder(
          itemCount: 16,
          padding: EdgeInsets.only(top: mq.height * .01),
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return const ChatUserCard();
          }),
    );
  }
}
