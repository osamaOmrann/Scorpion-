import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scorpion_plus/api/apis.dart';
import 'package:scorpion_plus/helper/dialogs.dart';
import 'package:scorpion_plus/main.dart';
import 'package:scorpion_plus/models/chat_user.dart';
import 'package:scorpion_plus/screens/profile_screen.dart';
import 'package:scorpion_plus/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> _list = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('message: $message');
      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume'))
          APIs.updateActiveStatus(true);
        if (message.toString().contains('pause'))
          APIs.updateActiveStatus(false);
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProfileScreen(user: APIs.me)));
                  },
                  icon: Icon(Icons.more_vert))
            ],
            leading: Icon(CupertinoIcons.home),
            title: _isSearching
                ? TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Name, Email, ...',
              ),
              autofocus: true,
              style: TextStyle(fontSize: 17, letterSpacing: .5),
              onChanged: (val) {
                _searchList.clear();
                for (var i in _list) {
                  if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                      i.email.toLowerCase().contains(val.toLowerCase())) {
                    _searchList.add(i);
                  }
                  setState(() {
                    _searchList;
                  });
                }
              },
            )
                : Text('Scorpion+'),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () {
                _addScorpionDialog();
              },
              child: Icon(Icons.add_comment_rounded),
            ),
          ),
          body: StreamBuilder(
            stream: APIs.getMyUsersIDs(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  return StreamBuilder(
                    stream: APIs.getAllUsers(
                        snapshot.data?.docs.map((e) => e.id).toList() ?? []),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _list = data
                                  ?.map((e) => ChatUser.fromJson(e.data()))
                                  .toList() ??
                              [];
                          if (_list.isNotEmpty) {
                            return ListView.builder(
                                itemCount: _isSearching
                                    ? _searchList.length
                                    : _list.length,
                                padding: EdgeInsets.only(top: mq.height * .01),
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ChatUserCard(
                                    user: _isSearching
                                        ? _searchList[index]
                                        : _list[index],
                                  );
                                  // return Text('Name: ${list[index]}');
                                });
                          } else {
                            return const Center(
                                child: Text(
                              'No Connections Found!',
                              style: TextStyle(fontSize: 20),
                            ));
                          }
                      }
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  void _addScorpionDialog() {
    String email = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding:
            EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(children: [
          Icon(
            CupertinoIcons.person_add,
            color: Colors.blue,
            size: 28,
          ),
          Text('  Add user')
        ]),
        content: TextFormField(
          maxLines: null,
          onChanged: (value) => email = value,
          decoration: InputDecoration(
              hintText: 'Email ID',
              prefixIcon: Icon(
                CupertinoIcons.mail_solid,
                color: Colors.blue,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'cancel',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              if (email.isNotEmpty)
                await APIs.addChatUser(email).then((value) {
                  if (!value)
                    Dialogs.showSnackbar(
                        context, 'There is no users with this e-mail');
                });
            },
            child: Text(
              'add',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
