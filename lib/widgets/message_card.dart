import 'package:flutter/material.dart';
import 'package:scorpion_plus/api/apis.dart';
import 'package:scorpion_plus/models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  Widget _blueMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue),
                  color: Color.fromARGB(255, 221, 245, 255),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04,
                  vertical: MediaQuery.of(context).size.height * .01),
              child: Text(
                widget.message.msg,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              )),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * .04),
          child: Text(
            widget.message.sent,
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .04,
            ),
            Icon(
              Icons.done_all_rounded,
              color: Colors.blue,
              size: 20,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              widget.message.read + ' 12:00 AM',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
        Flexible(
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  color: Color.fromARGB(255, 218, 255, 176),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04,
                  vertical: MediaQuery.of(context).size.height * .01),
              child: Text(
                widget.message.msg,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              )),
        )
      ],
    );
  }
}
