import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/Sqlfite/database_helper.dart';
import 'package:music_player_demo/widgets/favourite_song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../constants/songs_manager.dart';
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final DataBaseHelper _dataBaseHelper=DataBaseHelper();
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    initFavourites();
  }
  void initFavourites() async {
    await getFavourites();
  }
  getFavourites() async {
    SongsManager.favouriteSongs=await _dataBaseHelper.getFavourites();
    setState(() {});
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Colors.black,
      floatingActionButton: FloatingActionButton.small(
          elevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35)
          ),
          onPressed: () {
            setState(() {});
          },
          child: const Icon(CupertinoIcons.refresh, color: Colors.black,
            size: 20,)),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Container(
            padding: const EdgeInsets.only(bottom: 25),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white38,width: 2.5))
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: kToolbarHeight+0,bottom: 25),
                  child: ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1)
                    ),
                    title:Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("Favourites",style:GoogleFonts.aBeeZee(color: Colors.white,fontSize: 25.5,fontWeight: FontWeight.w700),),
                    ),
                    subtitle:Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("username",style: GoogleFonts.aBeeZee(color: Colors.white70,fontSize: 15),),
                    ),
                    trailing:  Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration:  BoxDecoration(
                          color: Colors.black,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.white12,
                                spreadRadius: 2.5,
                                blurRadius: 1.5,
                                offset: Offset(0.5, 0.5)
                            )],
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: IconButton(
                          onPressed: (){},
                          icon: const Icon(Icons.favorite_outlined,color:Colors.red,size: 25,)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.white54,
                          backgroundColor: Colors.redAccent,
                          elevation: 25,
                          alignment: Alignment.center,
                          fixedSize:const Size(110, 40),
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          )
                      ), child: Text("Play",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15.5,fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.white54,
                          backgroundColor: Colors.orangeAccent,
                          elevation: 25,
                          alignment: Alignment.center,
                          fixedSize:const Size(110, 40),
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          )
                      ), child: Text("Shuffle",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15.5,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ],
            ),
          ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: SongsManager.favouriteSongs.length,
              physics:const ScrollPhysics(),
              itemBuilder: (context, index) {
              return favouriteSong(index,audioQuery,context);
            },)
          ],
        ),
      ),
    );
  }
}
