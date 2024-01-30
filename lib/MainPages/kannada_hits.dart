import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../Sqlfite/database_helper.dart';
import '../constants/Global_Variables.dart';
import '../constants/songs_manager.dart';
import '../play_song/play_songs.dart';
import '../provider/songs_provider.dart';
import '../widgets/playlist_song_widgets.dart';
class KannadaHits extends StatefulWidget {
  const KannadaHits({super.key});

  @override
  State<KannadaHits> createState() => _KannadaHitsState();
}

class _KannadaHitsState extends State<KannadaHits> {
  List<SongModel>songs=[];
  OnAudioQuery audioQuery=OnAudioQuery();
  DataBaseHelper dataBaseHelper=DataBaseHelper();
  int counter=-1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSongs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x160793FF),
      appBar: AppBar(
        elevation: 15,
        shadowColor: Colors.white30,
        centerTitle: true,
        backgroundColor: Colors.black54,
        actions: [
          IconButton(
              onPressed: () {

              }, icon: const Icon(Icons.more_horiz_outlined,color: Colors.white,size: 28,)),
          const SizedBox(
            width: 15,
          ),
        ],
        title:Text(" Kannada Hits", style: GoogleFonts.manrope(
            color: Colors.white,
            fontSize: 18.5,
            fontWeight: FontWeight.w500),),
        toolbarHeight: kToolbarHeight,
      ),
      body: counter==-1?const Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,),):SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height:330,
              width: MediaQuery.sizeOf(context).width,
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
                id: songs[counter].id,
                type: ArtworkType.AUDIO,
                quality:100,
              ),
            ),
            const SizedBox(height: 20,),
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
                    title:Text("Kannada Hits",style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 17.5,fontWeight: FontWeight.w700),),
                    subtitle:ShaderMask(shaderCallback:(bounds) {
                      return GlobalVariables.getLineGradient().createShader(bounds);
                    },child: Text("6.8 hour listened activity",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 12.5,fontWeight: FontWeight.w500),)),
                  ),
                ),
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
                    icon: const Icon(CupertinoIcons.play_circle,color:Colors.white,size: 45,shadows: [
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

   getSongs() async {
     print("Start");
     List<SongModel>list=await audioQuery.querySongs(
         uriType: UriType.EXTERNAL
     );
     for(SongModel song in list) {
       if(song.genre!=null && song.genre=='Kannada') {
         songs.add(song);
       }
     }
     counter=Random().nextInt(songs.length);
        setState(() {});
   }
  }
