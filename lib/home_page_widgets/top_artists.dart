import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../constants/Global_Variables.dart';

Widget topArtists(BuildContext context,SongModel songModel)
{
  return ListTile(
    onTap: () {

    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(1)
    ),
    style: ListTileStyle.drawer,
    selected: true,
    selectedColor: GlobalVariables.appBarColor,
    title:Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(songModel.artist??"error occurred",style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15.5,fontWeight: FontWeight.w700),),
    ),
    subtitle:Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ShaderMask(shaderCallback:(bounds) {
        return GlobalVariables.getLineGradient().createShader(bounds);
      },child: Text(songModel.genre??"error occurred",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 12.5,fontWeight: FontWeight.w500),)),
    ),
  );
}