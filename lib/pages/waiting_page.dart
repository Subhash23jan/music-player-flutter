import 'dart:async';

import 'package:flutter/material.dart';
class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 1), () {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WaitingPage(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:Stack(
          alignment: Alignment.center,
          children: [
            Text("wait, it's updating!!",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
            CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,)
          ],
        ),
      ),
    );
  }
}
