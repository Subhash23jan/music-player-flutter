import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Sqlfite/database_helper.dart';
import '../constants/songs_manager.dart';
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
          decoration: const InputDecoration(
            hintText: 'Search for song',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            // Implement your search logic here
            // For simplicity, just print the entered search query
            print('Search query: $value');
          },
        ),
      ),
      body: const Center(
        child: Text('Search Screen Content',style: TextStyle(color: Colors.white),),
      ),
    );

  }

  getSongs() async {
    print("Start");
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
}
