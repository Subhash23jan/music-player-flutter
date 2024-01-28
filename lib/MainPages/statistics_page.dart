import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/Sqlfite/database_helper.dart';
import 'package:music_player_demo/constants/songs_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/recent_listens.dart';
import '../widgets/playlist_song_widgets.dart';
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  OnAudioQuery audioQuery=OnAudioQuery();
  DataBaseHelper dataBaseHelper=DataBaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 15,
          shadowColor: Colors.white30,
          centerTitle: true,
          backgroundColor: Colors.black,
          title:Text(" Music Statistics", style: GoogleFonts.manrope(
              color: Colors.white,
              fontSize: 18.5,
              fontWeight: FontWeight.w500),),
          toolbarHeight: kToolbarHeight,
        ),
        body:  SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
               Container(
                 margin: const EdgeInsets.symmetric(horizontal: 10),
                 child: Column(
                   children: [
                     const SizedBox(height: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         SizedBox(
                           width: MediaQuery.sizeOf(context).width*0.62,
                           child: ElevatedButton(
                             onPressed: (){},
                             child: Text(" Total Songs You have", style: GoogleFonts.manrope(
                                 color: Colors.black,
                                 fontSize: 17.5,
                                 fontWeight: FontWeight.w500),),
                           ),
                         ),
                         SizedBox(
                           width: MediaQuery.sizeOf(context).width*0.28,
                           child: ElevatedButton(
                             onPressed: (){},
                             style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.white54
                             ),
                             child: Text("${SongsManager.songsList.length}", style: GoogleFonts.manrope(
                                 color: Colors.black,
                                 fontSize: 14.5,
                                 fontWeight: FontWeight.w600),),
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         SizedBox(
                           width: MediaQuery.sizeOf(context).width*0.62,
                           child: ElevatedButton(
                             onPressed: (){},
                             child: Text(" Songs you have played", style: GoogleFonts.manrope(
                                 color: Colors.black,
                                 fontSize: 17.5,
                                 fontWeight: FontWeight.w500),),
                           ),
                         ),
                         SizedBox(
                           width: MediaQuery.sizeOf(context).width*0.28,
                           child: ElevatedButton(
                             onPressed: (){},
                             style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.white54
                             ),
                             child: Text("${SongsManager.recentListens.length}", style: GoogleFonts.manrope(
                                 color: Colors.black,
                                 fontSize: 14.5,
                                 fontWeight: FontWeight.w600),),
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         SizedBox(
                           width: MediaQuery.sizeOf(context).width*0.62,
                           child: ElevatedButton(
                             onPressed: (){},
                             child: Text("Your favourite Genre:", style: GoogleFonts.manrope(
                                 color: Colors.black,
                                 fontSize: 17.5,
                                 fontWeight: FontWeight.w500),),
                           ),
                         ),
                         ElevatedButton(
                           onPressed: (){},
                           style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.white54
                           ),
                           child: Center(
                             child: Text(" Kannada", style: GoogleFonts.manrope(
                                 color: Colors.black,
                                 fontSize: 14.5,
                                 fontWeight: FontWeight.w600),),
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 35,),
                   ],
                 ),
               ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text(" Recent Songs Of You!!", style: GoogleFonts.manrope(
                      color: Colors.redAccent,
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500),),
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  height: 600,
                  child:  ListView.builder(
                    itemCount: SongsManager.recentListens.length>=8?8:SongsManager.recentListens.length,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return playListSong(songModel: SongsManager.recentListens[index], audioQuery: audioQuery, dataBaseHelper: dataBaseHelper,index: index,songs: SongsManager.recentListens,);
                    },),
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text(" Top 10 Tracks Of You!!", style: GoogleFonts.manrope(
                  color: Colors.redAccent,
                  fontSize: 17.5,
                  fontWeight: FontWeight.w500),),
                ),
                const SizedBox(height: 15,),
                FutureBuilder<List<RecentSong>>(
                  future:DataBaseHelper().getTopTracks(),
                  builder: (context, item) {
                    // Display error, if any.
                    if (item.hasError) {
                      return Text(item.error.toString());
                    }

                    // Waiting content.
                    if (item.data == null) {
                      return const Center(child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2,));
                    }

                    // 'Library' is empty.
                    if (item.data!.isEmpty) return const Text("Nothing found!");
                    return ListView.builder(
                      itemCount:item.data!.length>=8?8:item.data!.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return playListSong(songModel:item.data![index], audioQuery: audioQuery, dataBaseHelper: dataBaseHelper, index: index, songs: item.data!);
                      },
                    );
                  },
                )

          ]),
        ),
      );
  }
}
