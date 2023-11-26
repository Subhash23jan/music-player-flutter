import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/Global_Variables.dart';
import '../play_song/play_songs.dart';

Widget playListSong(BuildContext context){
  return ListTile(
    titleAlignment: ListTileTitleAlignment.center,
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PlaySong(),));
    },
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1)
    ),
    leading: Card(
      elevation: 12,
      shadowColor: Colors.white24,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
                color: Colors.yellowAccent.shade400,
                width: 1.9
            )
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(GlobalVariables.imageUrl,width: 45,height: 45,fit: BoxFit.fill,)),
      ),
    ),
    style: ListTileStyle.drawer,
    selected: true,
    selectedColor: GlobalVariables.appBarColor,
    title:Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text("Song Name",style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15.5,fontWeight: FontWeight.w700),),
    ),
    subtitle:Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ShaderMask(shaderCallback:(bounds) {
        return GlobalVariables.getLineGradient().createShader(bounds);
      },child: Text("Artist name",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 12.5,fontWeight: FontWeight.w500),)),
    ),
    trailing:  SizedBox(
      width: MediaQuery.sizeOf(context).width*0.28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){},
              icon: Icon(CupertinoIcons.heart,color:Colors.yellow.shade800,size: 25,)),
          IconButton(onPressed: (){},
              icon:  Icon(Icons.play_circle_outline_outlined,color:Colors.yellow.shade800,size: 27,)),
        ],
      ),
    ),
  );
}
