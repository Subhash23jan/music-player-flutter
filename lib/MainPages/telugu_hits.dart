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
class TeluguHits extends StatefulWidget {
  const TeluguHits({super.key});

  @override
  State<TeluguHits> createState() => _TeluguHitsState();
}

class _TeluguHitsState extends State<TeluguHits> {
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
      body: counter==-1?const Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,),):SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15,left: 10,right: 10),
              height: MediaQuery.sizeOf(context).height*0.35,
              width: MediaQuery.sizeOf(context).width,
              child: Image.network(GlobalVariables.imageUrl,fit: BoxFit.cover,),
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
                    title:Text("Telugu Hits",style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15.5,fontWeight: FontWeight.w700),),
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
      if(song.genre!=null && song.genre=='Telugu') {
        songs.add(song);
      }
    }
    counter=0;
    setState(() {});
  }
}

