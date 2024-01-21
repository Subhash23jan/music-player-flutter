import 'package:flutter/material.dart';
import 'package:music_player_demo/main.dart';
import 'package:music_player_demo/pages/main_body.dart';
import 'package:permission_handler/permission_handler.dart';

import '../MainPages/home_page.dart';
class PermissionHandler extends StatefulWidget {
  const PermissionHandler({super.key});

  @override
  State<PermissionHandler> createState() => _PermissionHandlerState();
}

class _PermissionHandlerState extends State<PermissionHandler> {
  bool isChecked=false;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    checkGrants();
    getPermission();

  }
  checkGrants() async {
    if(await Permission.storage.isGranted){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainBodyPage(index: 0,),));
    }
  }

   getPermission() async {
    var result=await Permission.storage.request();
    if(result.isGranted){
      if(context.mounted) {
        return  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainBodyPage(index: 0,),));
      }
    }else {
      return getPermission();
    }
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
      )
    );
  }
}
