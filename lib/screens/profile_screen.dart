import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scorpion_plus/api/apis.dart';
import 'package:scorpion_plus/helper/dialogs.dart';
import 'package:scorpion_plus/main.dart';
import 'package:scorpion_plus/models/chat_user.dart';
import 'package:scorpion_plus/screens/auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            Dialogs.showProgressbar(context);
            await APIs.auth.signOut().then((value) async {
              await GoogleSignIn().signOut().then((value) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              });
            });
          },
          icon: Icon(Icons.logout),
          label: Text('Logout'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
        child: Column(
          children: [
            SizedBox(
              width: mq.width,
              height: mq.height * .03,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .1),
                  child: CachedNetworkImage(
                    width: mq.height * .2,
                    height: mq.height * .2,
                    fit: BoxFit.fill,
                    imageUrl: widget.user.image,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      elevation: 1,
                      onPressed: () {},
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      color: Colors.white,
                      shape: CircleBorder(),
                    ))
              ],
            ),
            SizedBox(
              height: mq.height * .03,
            ),
            Text(
              widget.user.email,
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            SizedBox(
              height: mq.height * .05,
            ),
            TextFormField(
              initialValue: widget.user.name,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.person_alt,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'eg. Happy Singh',
                  labelText: 'Name'),
            ),
            SizedBox(
              height: mq.height * .02,
            ),
            TextFormField(
              initialValue: widget.user.about,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.info,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'eg. Feeling Happy',
                  labelText: 'About'),
            ),
            SizedBox(
              height: mq.height * .05,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  minimumSize: Size(mq.width * .5, mq.height * .06)),
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 30,
              ),
              label: Text(
                'Update',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
