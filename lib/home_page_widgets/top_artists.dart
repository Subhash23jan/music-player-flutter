import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/play_song/play_songs.dart';

import '../constants/Global_Variables.dart';

Widget topArtists(BuildContext context)
{
  return ListTile(
    titleAlignment: ListTileTitleAlignment.center,
    onTap: () {
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PlaySong(),));
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(1)
    ),
    leading: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.cyan.shade400,
          width: 1.9
        )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
          child: Image.network(GlobalVariables.imageUrl,width: 40,height: 40,fit: BoxFit.fill,)),
    ),
    style: ListTileStyle.drawer,
    selected: true,
    selectedColor: GlobalVariables.appBarColor,
    title:Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text("Dua Lipa",style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15.5,fontWeight: FontWeight.w700),),
    ),
    subtitle:Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ShaderMask(shaderCallback:(bounds) {
        return GlobalVariables.getLineGradient().createShader(bounds);
      },child: Text("Pop ",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 12.5,fontWeight: FontWeight.w500),)),
    ),
  );
}