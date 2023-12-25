import 'package:flutter/material.dart';
import 'package:music_player_demo/main.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_page.dart';
class PermissionHandler extends StatefulWidget {
  const PermissionHandler({super.key});

  @override
  State<PermissionHandler> createState() => _PermissionHandlerState();
}

class _PermissionHandlerState extends State<PermissionHandler> {
  bool isChecked=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }
   getPermission() async {
    var result=await Permission.storage.request();
    if(result.isGranted){
      if(context.mounted) {
        return  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage(),));
      }
    }else {
      return getPermission();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("To operate we need a access to your storage ",style: TextStyle(color: Colors.white),),
            const SizedBox(height: 25,),
            ElevatedButton(onPressed: (){
               return getPermission();
            },
                style: ElevatedButton.styleFrom(elevation: 15,shadowColor: Colors.white,backgroundColor: Colors.white54),
                child:const Text("Give Permission",style: TextStyle(color: Colors.white),)),
          ],
        ),
      )
    );
  }
}
