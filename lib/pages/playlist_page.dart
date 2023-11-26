import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/widgets/playlist_song_widgets.dart';

import '../constants/Global_Variables.dart';
import '../play_song/play_songs.dart';
class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
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
                    title:Text("Best of 90's",style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15.5,fontWeight: FontWeight.w700),),
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
                    icon: Icon(CupertinoIcons.shuffle,color:Colors.yellow.shade800,size: 35,shadows: [
                    ],)),
                IconButton(onPressed: (){},
                    style:  ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(15), // Set the elevation as needed
                      shadowColor: MaterialStateProperty.all<Color>(Colors.white12),
                      // Set the button color
                    ),
                    icon: Icon(CupertinoIcons.play_circle,color:Colors.yellow.shade800,size: 45,shadows: [
                    ],)),
              ],
            ),
            const SizedBox(height: 10,),
            ListView.builder(
              itemCount: 10,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
              return playListSong(context);
            },)
          ],
        ),
      ),
    );
  }
}
