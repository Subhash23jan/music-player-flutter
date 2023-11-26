import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/constants/global_variables.dart';

Widget pickedSong(BuildContext context){
  return Container(
    margin: const EdgeInsets.only(right: 18),
    height: 150,
    width: MediaQuery.sizeOf(context).width*0.6,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
    child:  Row(
      children: [
        ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12),topLeft: Radius.circular(12)),
            child: Image.network(GlobalVariables.imageUrl,fit:BoxFit.cover,width: MediaQuery.sizeOf(context).width*0.3,height:150,opacity:const AlwaysStoppedAnimation(0.7),)),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("Song name",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12),topRight: Radius.circular(12)),
                    child: Image.network(GlobalVariables.imageUrl,fit:BoxFit.cover,width: MediaQuery.sizeOf(context).width*0.3,height:150,opacity:const AlwaysStoppedAnimation(0.3),)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}