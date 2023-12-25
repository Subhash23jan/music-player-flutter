import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/constants/songs_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';
Widget recentPlays(BuildContext context,int index,OnAudioQuery audioQuery){
   const String imageUrl="https://images.firstpost.com/wp-content/uploads/2017/04/prabhas-baahubali.jpg";
  return Container(
    margin: const EdgeInsets.only(right: 18),
    height: 100,
    width: MediaQuery.sizeOf(context).width*0.8,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
    child:  Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(SongsManager.recentListens[index].title,style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),),
        ),
        SizedBox(
          width:MediaQuery.sizeOf(context).width*0.4,
            child: QueryArtworkWidget(
              controller: audioQuery,
              id: SongsManager.recentListens[index].id,
              type: ArtworkType.AUDIO,
              artworkFit: BoxFit.fill,
            )
        ),
      ],
    ),
  );
}