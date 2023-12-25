import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../constants/Global_Variables.dart';
import '../constants/songs_manager.dart';

Widget favouriteSong(int index,OnAudioQuery audioQuery){
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1)
        ),
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Colors.cyanAccent.shade700,
                  width: 1.9
              )
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
            child:QueryArtworkWidget(
            controller: audioQuery,
            id: SongsManager.favouriteSongs[index].id,
            type: ArtworkType.AUDIO,
          ),
        ),),
        title:Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(SongsManager.favouriteSongs[index].displayName,style:GoogleFonts.manrope(color: Colors.white70,fontSize: 15.5,fontWeight: FontWeight.w600),),
        ),
        subtitle:Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(SongsManager.favouriteSongs[index].artist??"unknown",style: GoogleFonts.manrope(color: Colors.white38,fontSize: 12.5),),
        ),
        trailing:  IconButton(
            onPressed: (){},
            style: const ButtonStyle(),
            icon: const Icon(Icons.favorite_outlined,color:Colors.redAccent,size: 27,))
    ),
  );
}