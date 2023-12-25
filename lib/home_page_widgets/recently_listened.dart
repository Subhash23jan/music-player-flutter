import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/constants/songs_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';
Widget recentPlays(BuildContext context,int index,OnAudioQuery audioQuery){
  return Container(
    margin: const EdgeInsets.only(right: 18),
    height: MediaQuery.sizeOf(context).height*0.4,
    width: MediaQuery.sizeOf(context).width*0.8,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
    child:  Stack(
      alignment: Alignment.center,
      children: [
        QueryArtworkWidget(
          controller: audioQuery,
          artworkBorder: BorderRadius.circular(18),
          artworkHeight: MediaQuery.sizeOf(context).height * 0.8,
          artworkWidth: MediaQuery.of(context).size.width * 0.8,
          artworkFit: BoxFit.cover,
          id: SongsManager.recentListens[index].id,
          type: ArtworkType.AUDIO,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(SongsManager.recentListens[index].title,style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),),
        ),
      ],
    ),
  );
}