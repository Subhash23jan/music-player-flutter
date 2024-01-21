import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/constants/songs_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';
Widget recentPlays(BuildContext context,int index,OnAudioQuery audioQuery){
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(right: 18),
    height: MediaQuery.sizeOf(context).height*0.5,
    width: MediaQuery.sizeOf(context).width*0.5,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
    child:  Column(
      children: [
        Container(
          height:120,
          width: MediaQuery.sizeOf(context).width*0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color:Colors.white10,
              border: Border.all(
                  color: Colors.cyanAccent,
                  width: .1
              )
          ),
          child: QueryArtworkWidget(
            controller: audioQuery,
            artworkFit: BoxFit.cover,
            artworkQuality: FilterQuality.high,
            artworkBorder:  BorderRadius.circular(25),
            id: SongsManager.recentListens[index].id,
            type: ArtworkType.AUDIO,
            quality:100,
          ),
        ),
        const SizedBox(height: 15,),
        Container(
          alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            width: MediaQuery.sizeOf(context).width*0.48,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Colors.white10,
            ),
            child: Text(SongsManager.recentListens[index].title,style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 12),overflow:TextOverflow.ellipsis,maxLines: 1,)),
      ],
    ),
  );
}