import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../Sqlfite/database_helper.dart';
import '../constants/Global_Variables.dart';
import '../constants/songs_manager.dart';
import '../play_song/play_songs.dart';
import '../provider/songs_provider.dart';
import '../songs/song_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoaded=false;
  OnAudioQuery audioQuery=OnAudioQuery();
  DataBaseHelper dataBaseHelper=DataBaseHelper();
  static List<SongModel>songList=[];
  int searchState=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSongs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            songList.clear();
            searchState=1;
            if(value.isNotEmpty) {
              searchSongs(value);
            }else{
              searchState=0;
              setState(() {});
            }
          },
          decoration: const InputDecoration(
            hintText: 'Search for song',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            // Implement your search logic here
            // For simplicity, just print the entered search query
            searchState=1;
            searchSongs(value);
            if (kDebugMode) {
              print('Search query: $value');
            }
          },
        ),
      ),
      body:  searchState==0?const Center(child: Text('Type song/album/artist name in search bar',style: TextStyle(color: Colors.white),)):
          searchState==1?const Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2)):
      ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context, index) {
          return ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            onTap: () {
              Provider.of<SongsProvider>(
                  context, listen: false)
                  .updateCurrentSong(songList[index]);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return PlaySong(
                        audioQuery: audioQuery,
                        songList:songList,
                        index: index);
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
                    controller: audioQuery,
                    id: songList[index].id,
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
                songList[index].displayName,
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
                  songList[index].artist ??
                      songList[index].composer ??
                      songList[index].genre ??
                      songList[index].displayNameWOExt,
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
          );
      },),
    );

  }

  getSongs() async {
    print("Start");
    if(SongsManager.songsList.isNotEmpty) {
      return;
    }
    List<SongModel>list=await audioQuery.querySongs(
        uriType: UriType.EXTERNAL
    );

    for(SongModel song in list) {
       {
        DataBaseHelper dataBaseHelper=DataBaseHelper();
        dataBaseHelper.addSongToDatabase(song);
      }
    }
  }

  void searchSongs(String value) {
    print(value);
    value=value.toLowerCase();
    for(int i=0;i<SongsManager.songsList.length;i++){
      if(SongsManager.songsList[i].displayName.toLowerCase().contains(value) || SongsManager.songsList[i].title.toLowerCase().contains(value)||
          SongsManager.songsList[i].album!.toLowerCase().contains(value) || SongsManager.songsList[i].artist!.toLowerCase().contains(value) || (SongsManager.songsList[i].composer!=null && SongsManager.songsList[i].composer!.toLowerCase().contains(value))
      ){
        songList.add(SongsManager.songsList[i]);
      }
    }
    searchState=2;
    setState(() {});
  }
}
