import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../constants/Global_Variables.dart';

Widget topTracks(BuildContext context,SongModel songModel)
{
  return ListTile(
    leading: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: Colors.orangeAccent.shade700.withOpacity(0.4),
              width: 1.9
          )
      ),
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child:QueryArtworkWidget(
          controller: OnAudioQuery(),
          id: songModel.id,
          type: ArtworkType.AUDIO,
        ),),
    ),
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("feature has been developing!!🥺"),duration: Duration(milliseconds: 700),));
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(1)
    ),
    style: ListTileStyle.drawer,
    selected: true,
    selectedColor: GlobalVariables.appBarColor,
    title:Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(songModel.title,style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15.5,fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis,maxLines: 1,),
    ),
    subtitle:Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ShaderMask(shaderCallback:(bounds) {
        return GlobalVariables.getLineGradient().createShader(bounds);
      },child: Text(songModel.genre??"unknown",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 12.5,fontWeight: FontWeight.w500),)),
    ),
  );
}