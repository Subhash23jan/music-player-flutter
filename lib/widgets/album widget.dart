import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget showAlbum(BuildContext context,AlbumModel albumModel)
{
  final OnAudioQuery audioQuery=OnAudioQuery();
  return Container(
    color: Colors.black12,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: Colors.cyanAccent.shade700,
                    width: 1.9
                )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child:QueryArtworkWidget(
                controller: audioQuery,
                id: albumModel.id,
                artworkFit: BoxFit.cover,
                artworkBorder: BorderRadius.circular(25),
                type: ArtworkType.AUDIO,
              ),
            ),),
          Text(albumModel.artist??albumModel.album)
        ],
      ),
  );
}