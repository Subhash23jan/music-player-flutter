import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../constants/songs_manager.dart';

Widget showAlbum(BuildContext context,AlbumModel albumModel)
{
  print(albumModel.id);
  final OnAudioQuery audioQuery=OnAudioQuery();
  return Container(
    color: Colors.white10,
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width*0.47,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: Colors.greenAccent.shade700,
                    width: 2
                )
            ),
            child: QueryArtworkWidget(
              controller: audioQuery,
              id: albumModel.id,
              artworkFit: BoxFit.cover,
              artworkWidth: MediaQuery.sizeOf(context).width*0.45,
              artworkHeight: 160,
              artworkBorder: BorderRadius.circular(25),
              type:ArtworkType.ALBUM,

            ),),
            const SizedBox(height: 7,),
             Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              width: MediaQuery.sizeOf(context).width*0.48,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:Colors.white10,
              ),
              child: Text(albumModel.album,style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 11),overflow:TextOverflow.ellipsis,maxLines: 1,)),
          const SizedBox(height: 5,)
        ],
      ),
  );
}