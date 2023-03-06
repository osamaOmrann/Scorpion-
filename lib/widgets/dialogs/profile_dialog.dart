import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scorpion_plus/main.dart';
import 'package:scorpion_plus/models/chat_user.dart';
import 'package:scorpion_plus/screens/veiw_profile_screen.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({Key? key, required this.user}) : super(key: key);

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
          width: mq.width * .6,
          height: mq.height * .35,
          child: Stack(
            children: [
              Positioned(
                top: mq.height * .075,
                left: mq.width * .1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .25),
                  child: CachedNetworkImage(
                    width: mq.width * .5,
                    fit: BoxFit.cover,
                    imageUrl: user.image,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),
              ),
              Positioned(
                left: mq.width * .04,
                top: mq.height * .02,
                width: mq.width * .55,
                child: Text(
                  user.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Positioned(
                  right: 8,
                  top: 6,
                  child: MaterialButton(
                    minWidth: 0,
                    padding: EdgeInsets.all(0),
                    shape: CircleBorder(),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewProfileScreen(user: user)));
                    },
                    child: Icon(
                      CupertinoIcons.info,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ))
            ],
          )),
    );
  }
}
