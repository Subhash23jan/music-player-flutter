import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/Sqlfite/database_helper.dart';
import 'package:music_player_demo/models/favourites_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../constants/Global_Variables.dart';
import '../play_song/play_songs.dart';
import '../provider/songs_provider.dart';

class playListSong extends StatefulWidget {
  final SongModel songModel;
  final OnAudioQuery audioQuery;
  final DataBaseHelper dataBaseHelper;
  final int index;
  final List<SongModel>songs;

  const playListSong({super.key, required this.songModel, required this.audioQuery, required this.dataBaseHelper,required this.index, required this.songs});


  @override
  _playListSongState createState() => _playListSongState();
}

class _playListSongState extends State<playListSong> {
  bool isInLikedList = false;

  @override
  void initState() {
    super.initState();
    _checkIfInLikedList();
  }

  Future<void> _checkIfInLikedList() async {
    bool isPresent = await widget.dataBaseHelper.isPresentInFavourites(widget.songModel.id);
    setState(() {
      isInLikedList = isPresent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      onTap: () {
        Provider.of<SongsProvider>(
            context, listen: false)
            .updateCurrentSong(widget.songs[widget.index]);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return PlaySong(
                  audioQuery: widget.audioQuery,
                  songList:widget.songs,
                  index: widget.index);
            },));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1),
      ),
      leading: Card(
        elevation: 12,
        shadowColor: Colors.white24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.redAccent.shade700.withOpacity(0.4),
              width: 1.9,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: QueryArtworkWidget(
              controller: widget.audioQuery,
              id: widget.songModel.id,
              type: ArtworkType.AUDIO,
              artworkWidth: 45,
              artworkHeight: 45,
              artworkFit: BoxFit.cover,
            ),
          ),
        ),
      ),
      style: ListTileStyle.drawer,
      selected: true,
      selectedColor: GlobalVariables.appBarColor,
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          widget.songModel.displayName,
          style: GoogleFonts.aBeeZee(
            color: Colors.white,
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ShaderMask(
          shaderCallback: (bounds) {
            return GlobalVariables.getLineGradient().createShader(bounds);
          },
          child: Text(
            widget.songModel.artist ??
                widget.songModel.composer ??
                widget.songModel.genre ??
                widget.songModel.displayNameWOExt,
            style: GoogleFonts.aBeeZee(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.28,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isInLikedList
                ? IconButton(
              onPressed: () {
                DataBaseHelper dbhelper=DataBaseHelper();
               dbhelper.addFavourites(Favourites(widget.songs[widget.index].getMap));
                isInLikedList = false;
                setState(() {});
              },
              icon: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.yellow.shade900,
                size: 25,
              ),
            )
                : IconButton(
              onPressed: () {
                DataBaseHelper dbhelper=DataBaseHelper();
               dbhelper.addFavourites(Favourites(widget.songs[widget.index].getMap));
                isInLikedList = true;
                setState(() {});
              },
              icon: Icon(
                CupertinoIcons.heart,
                color: Colors.yellow.shade900,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {
                Provider.of<SongsProvider>(
                    context, listen: false)
                    .updateCurrentSong(widget.songs[widget.index]);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return PlaySong(
                          audioQuery: widget.audioQuery,
                          songList:widget.songs,
                          index: widget.index);
                    },));
              },
              icon: const Icon(
                Icons.play_circle_outline_outlined,
                color: Colors.white,
                size: 27,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
