import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/Sqlfite/database_helper.dart';
import 'package:music_player_demo/constants/songs_manager.dart';
import 'package:music_player_demo/widgets/playlist_song_widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Global_Variables.dart';
import '../play_song/play_songs.dart';
import '../provider/songs_provider.dart';
class SuggestionSongsPage extends StatefulWidget {
  const SuggestionSongsPage({super.key});

  @override
  State<SuggestionSongsPage> createState() => _SuggestionSongsPageState();
}
class _SuggestionSongsPageState extends State<SuggestionSongsPage> {
  List<SongModel>songs=[];
  OnAudioQuery audioQuery=OnAudioQuery();
  DataBaseHelper dataBaseHelper=DataBaseHelper();
  int counter=-1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSuggestedSongs();
    getListeningHours();
  }
  @override
  Widget build(BuildContext context) {
    return counter==-1?const Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,),):Scaffold(
      backgroundColor: const Color(0x160793FF),
      appBar:AppBar(
        backgroundColor: Colors.black26,
        toolbarHeight: kToolbarHeight-10,
        elevation: 38,
        shadowColor: Colors.black12,
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon:const Icon(Icons.arrow_back,color: Colors.white70)),
        actions: [
          IconButton(
              onPressed: () {

          }, icon: const Icon(Icons.more_horiz_outlined,color: Colors.white,size: 28,)),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15,left: 10,right: 10),
              height: MediaQuery.sizeOf(context).height*0.35,
              width: MediaQuery.sizeOf(context).width,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(GlobalVariables.imageUrl)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width*0.5,
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1)
                    ),
                    style: ListTileStyle.drawer,
                    selected: true,
                    selectedColor: GlobalVariables.appBarColor,
                    title:Text("Best for Yours",style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15.5,fontWeight: FontWeight.w700),),
                    subtitle:ShaderMask(shaderCallback:(bounds) {
                      return GlobalVariables.getLineGradient().createShader(bounds);
                    },child: Text("6.8 hour listened activity",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 12.5,fontWeight: FontWeight.w500),)),
                  ),
                ),
                IconButton(onPressed: (){},
                    style:  ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(15), // Set the elevation as needed
                      shadowColor: MaterialStateProperty.all<Color>(Colors.white12),
                      // Set the button color
                    ),
                    icon: Icon(CupertinoIcons.shuffle,color:Colors.yellow.shade800,size: 35,shadows: const [
                    ],)),
                IconButton(onPressed: (){
                  Provider.of<SongsProvider>(
                      context, listen: false)
                      .updateCurrentSong(songs[0]);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return PlaySong(
                            audioQuery: audioQuery,
                            songList:songs,
                            index:0);
                      },));
                },
                    style:  ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(15), // Set the elevation as needed
                      shadowColor: MaterialStateProperty.all<Color>(Colors.white12),
                      // Set the button color
                    ),
                    icon: Icon(CupertinoIcons.play_circle,color:Colors.yellow.shade800,size: 45,shadows: const [
                    ],)),
              ],
            ),
            const SizedBox(height: 10,),
            ListView.builder(
              itemCount: songs.length,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return playListSong(songModel: songs[index], audioQuery: audioQuery, dataBaseHelper: dataBaseHelper,index: index,songs: songs,);
              },)
          ],
        ),
      ),
    );
  }

  void getSuggestedSongs() {
    songs.addAll(SongsManager.recentListens);
    songs.addAll(SongsManager.favouriteSongs);
    int index=0;
    while(++index<10){
      int random=Random().nextInt(SongsManager.songsList.length-1);
      songs.add(SongsManager.songsList[random]);
    }
    songs.shuffle();
    counter=0;
    setState(() {});
  }

  Future<void> getListeningHours() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    counter=prefs.getInt("activity")??0;
  }


}
