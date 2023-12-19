import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../constants/Global_Variables.dart';
import '../play_song/play_songs.dart';

Widget songWidget(BuildContext context,SongModel songModel, OnAudioQuery audioQuery,){
  return ListTile(
    titleAlignment: ListTileTitleAlignment.center,
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  PlaySong(songModel: songModel,audioQuery: audioQuery ),));
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
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
                color: Colors.redAccent.shade700.withOpacity(0.4),
                width: 1.9
            )
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:QueryArtworkWidget(
             controller: audioQuery,
             id: songModel.id,
             type: ArtworkType.AUDIO,
        ),),
      ),
    ),
    title:Padding(
      padding: const EdgeInsets.only(left: 1),
      child: Text(songModel.displayName,style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 13.5,fontWeight: FontWeight.w700),maxLines: 1,
        overflow: TextOverflow.ellipsis,),
    ),
    subtitle:Padding(
      padding: const EdgeInsets.only(left: 1),
      child: ShaderMask(shaderCallback:(bounds) {
        return GlobalVariables.getLineGradient().createShader(bounds);
      },child: Text(songModel.artist??"unknown",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 12.5,fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,)),
    ),
    trailing:IconButton(onPressed: (){},
        padding: const EdgeInsets.only(left: 5),
        icon: const Icon(CupertinoIcons.heart,color:Colors.redAccent,size: 25,)),
  );
}