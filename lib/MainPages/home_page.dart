import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/Sqlfite/database_helper.dart';
import 'package:music_player_demo/constants/songs_manager.dart';
import 'package:music_player_demo/models/recent_listens.dart';
import 'package:music_player_demo/pages/playlist_page.dart';
import 'package:music_player_demo/play_song/play_songs.dart';
import 'package:music_player_demo/songs/other_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../constants/Global_Variables.dart';
import '../home_page_widgets/picked_song_card.dart';
import '../home_page_widgets/recently_listened.dart';
import '../home_page_widgets/top_artists.dart';
import '../provider/songs_provider.dart';
import '../songs/all_songs.dart';
import 'favourites_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  bool permission = false;
  int index = 0;
  final global = GlobalVariables();
  List<IconData>iconsList=[CupertinoIcons.music_note_2,CupertinoIcons.music_note_list];
  final DataBaseHelper _dataBaseHelper = DataBaseHelper();
  int iconIndex=0;
  final ScrollController _controller = ScrollController(
    keepScrollOffset: true,
  );

  @override
  void initState() {
    super.initState();
  }

  void getSongList() async {
    FutureBuilder<List<SongModel>>(
      future: audioQuery.querySongs(
        uriType: UriType.EXTERNAL,
        sortType: SongSortType.ALBUM,
        ignoreCase: true,
      ),
      builder: (BuildContext context, AsyncSnapshot<List<SongModel>> item) {
        if (item.hasError) {
          return Text(item.error.toString());
        }
        if (item.data == null) {
          return const Center(child: CircularProgressIndicator(
            color: Colors.white, strokeWidth: 2,));
        }
        if (item.data!.isEmpty) return const Text("Nothing found!");
        SongsManager.songsList = item.data!;
        print(SongsManager.songsList.length);
        setState(() {});
        return const SizedBox();
      },
    );
  }
  getRecent( BuildContext context) async {
    print("Subhash");
    SongsManager.recentListens = await _dataBaseHelper.getRecent();
  }

  @override
  Widget build(BuildContext context) {
    getRecent(context);
   // Provider.of<SongsProvider>(context).getRecentSongs();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade900,
        toolbarHeight: kToolbarHeight + 5,
        elevation: 18,
        shadowColor: Colors.white24,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery
                  .sizeOf(context)
                  .width * 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 90,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: GlobalVariables.buttonGradient
                    ),
                    child: Text("Home", style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AllSongs(),)),
                    child: Container(
                      width: 90,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: GlobalVariables.buttonGradient
                      ),
                      child: Text("Music", style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OtherSongs(),)),
                    child: Container(
                      width: 90,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: GlobalVariables.buttonGradient
                      ),
                      child: Text("Others", style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(CupertinoIcons.music_note_list,color: Colors.white,size: 30,)
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 18),
                alignment: Alignment.center,
                height: 200, child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return GlobalVariables.getLineGradient().createShader(
                          bounds);
                    },
                    child: Text(
                      "Picked for you",
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  SizedBox(
                    height: 145,
                    child: FutureBuilder<List<SongModel>>(
                      future: audioQuery.querySongs(
                        uriType: UriType.EXTERNAL,
                        sortType: SongSortType.ALBUM,
                        ignoreCase: true,
                      ),
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
                        if (item.data!.isEmpty) {
                          return const Text(
                            "Nothing found!");
                        }

                        // You can use [item.data!] direct or you can create a:
                        SongsManager.songsList = item.data!;
                        return ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildPickedSongs();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              ),
              const SizedBox(height: 15,),
              SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                          shaderCallback: (bounds) {
                            return GlobalVariables.getLineGradient()
                                .createShader(bounds);
                          },
                          child: Text(
                            "Recently listened",
                            style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 17.5, fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(height: 15,),
                      Consumer<SongsProvider>(
                        builder: (context, songProvider,  child) {
                          songProvider.getRecentSongs();
                          List<RecentSong>recentSongs=songProvider.recentListens;
                          print(recentSongs.length);
                          return SizedBox(
                            height: 155,
                            child: recentSongs.isNotEmpty
                                ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: recentSongs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  GestureDetector(
                                      onTap: () {
                                        //   List<SongModel>songs = SongsManager.recentListens.reversed.toList();

                                        Provider.of<SongsProvider>(
                                            context, listen: false)
                                            .updateCurrentSong(recentSongs[index]);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) {
                                              return PlaySong(
                                                  audioQuery: audioQuery,
                                                  songList:SongsManager.recentListens,
                                                  index: index);
                                            },));
                                      },
                                      child: recentPlays(context,
                                          index, audioQuery)),)
                                : const Text(
                              "You haven't played any songs ,Let's start your day with songs",
                              style: TextStyle(color: Colors.white, fontSize: 18),),
                          );
                        },

                      )
                    ],
                  )),
              const SizedBox(height: 15,),
              Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  height: 145,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(shaderCallback: (bounds) {
                        return GlobalVariables.getLineGradient().createShader(
                            bounds);
                      },
                          child: Text(" Collections",
                            style: GoogleFonts.manrope(color: Colors.white,
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500),)),
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.only(right: 10),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Card(
                              elevation: 12,
                              shadowColor: Colors.cyan,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),

                              child: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.cyanAccent,
                                            Colors.lightBlue,
                                            Colors.cyan.shade800
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: InkWell(
                                    onTap: () =>
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (
                                                context) => const PlaylistPage(),)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          "Best of the",
                                          style: GoogleFonts.manrope(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "90's",
                                          style: GoogleFonts.redHatMono(
                                            color: Colors.white,
                                            fontSize: 33,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                            const SizedBox(width: 15,),
                            Card(
                              elevation: 45,
                              shadowColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: InkWell(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(builder: (
                                        context) => const FavouritesPage(),)),
                                child: Container(
                                    height: 100,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors: [
                                              Colors.pinkAccent,
                                              Color.fromARGB(255, 213, 56, 208),
                                              Color.fromARGB(255, 228, 68, 161),
                                              Colors.pinkAccent
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          "This is",
                                          style: GoogleFonts.manrope(
                                            color: Colors.white,
                                            fontSize: 17,

                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "POP",
                                          style: GoogleFonts.redHatMono(
                                            color: Colors.white,
                                            fontSize: 33,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )

                                ),
                              ),
                            ),
                            const SizedBox(width: 15,),
                            Card(
                              elevation: 45,
                              shadowColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          colors: [
                                            Colors.cyan,
                                            Colors.green,
                                            Colors.cyan
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "All Out",
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                          fontSize: 17,

                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "2010",
                                        style: GoogleFonts.redHatMono(
                                          color: Colors.white,
                                          fontSize: 33,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )

                              ),
                            ),
                            const SizedBox(width: 15,),
                            Card(
                              elevation: 45,
                              shadowColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          colors: [
                                            Colors.yellow,
                                            Colors.orange,
                                            Colors.orangeAccent
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "We will",
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                          fontSize: 17,

                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Rock",
                                        style: GoogleFonts.redHatMono(
                                          color: Colors.white,
                                          fontSize: 33,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )

                              ),
                            ),
                            const SizedBox(width: 15,),
                            Card(
                              elevation: 45,
                              shadowColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          colors: [
                                            Colors.pink,
                                            Colors.red,
                                            Colors.pink,
                                            Color.fromARGB(255, 226, 216, 216)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Rhythm of",
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                          fontSize: 17,

                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "Love",
                                        style: GoogleFonts.redHatMono(
                                          color: Colors.white,
                                          fontSize: 33,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )

                              ),
                            ),


                          ],
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 10,),
              ShaderMask(shaderCallback: (bounds) {
                return GlobalVariables.getLineGradient().createShader(bounds);
              },
                  child: Text(" Top 10 Tracks Of You!!", style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500),)),
              FutureBuilder<List<SongModel>>(
                future: audioQuery.querySongs(
                  uriType: UriType.EXTERNAL,
                  sortType: SongSortType.ALBUM,
                  ignoreCase: true,
                ),
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

                  // You can use [item.data!] direct or you can create a:
                  SongsManager.songsList = item.data!;
                  return ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return item.data![index].artist != "unknown" ? topArtists(
                          context, item.data![index]) : const SizedBox();
                    },
                  );
                },
              )

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
          elevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35)
          ),
          onPressed: () {
            if (_controller.hasClients) {
              if (kDebugMode) {
                print("clicked");
              }
              final position = _controller.position.minScrollExtent;
              print(position);
              _controller.animateTo(
                position,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            }
          },
          child: const Icon(
            CupertinoIcons.arrow_up_to_line_alt, color: Colors.black,
            size: 20,)),
    );
  }

  Widget buildPickedSongs() {
    int index = Random().nextInt(SongsManager.songsList.length - 1);
    return GestureDetector(
      onTap: () {
        Provider.of<SongsProvider>(context, listen: false).updateCurrentSong(
            SongsManager.songsList[index]);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return PlaySong(
              audioQuery: audioQuery,
              songList: [SongsManager.songsList[index]],
              index: 0,
            );
          },
        ));
      },
      child: pickedSong(context, audioQuery, index),
    );
  }
}
