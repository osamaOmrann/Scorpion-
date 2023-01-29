import 'package:scorpion_plus/main.dart';
import 'package:scorpion_plus/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), (){
      setState(() {
        _isAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome to Scorpion+'),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
              top: mq.height * .15,
              right: _isAnimate? mq.width * .25: -mq.width * .5,
              width: mq.width * .5,
              duration: Duration(
                seconds: 1
              ),
              child: Image.asset('images/icon.png')),
          Positioned(
              bottom: mq.height * .15,
              left: mq.width * .05,
              width: mq.width * .9,
              height: mq.height * .05,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 219, 255, 178),
                  shape: StadiumBorder(),
                  elevation: 1
                ),
                  onPressed: () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                  },
                  icon: Image.asset('images/google.png', height: mq.height * .03,),
                  label: RichText(text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                    TextSpan(text: 'Login with'),
                    TextSpan(text: 'Google', style: TextStyle(fontWeight: FontWeight.w500)),
                  ]),)))
        ],
      ),
    );
  }
}