import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_demo/Sqlfite/database_helper.dart';
import 'package:music_player_demo/models/favourites_model.dart';
import 'package:music_player_demo/provider/songs_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../constants/Global_Variables.dart';
import '../constants/songs_manager.dart';

class PlaySong extends StatefulWidget {
  const PlaySong({super.key, required this.audioQuery, required this.songList, required this.index});
  final List<SongModel> songList;
  final int index;
  final OnAudioQuery audioQuery;

  @override
  State<PlaySong> createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final DataBaseHelper _dataBaseHelper=DataBaseHelper();
  double sliderValue = 0.0;
  double position=0;
  bool isPlaying = true;
  final List<String> lyrics = [
    "please wait ",
    "Our team is working ",
    "for this feature",
    "Thanks - Team Shashank",
  ];
  bool isLyricsOpened = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => playSongFromUri(context));
  }

  Future<void> playSongFromUri(BuildContext context) async {
    SongModel song = Provider.of<SongsProvider>(context, listen: false).currentSong;
    _dataBaseHelper.addToRecent(Favourites(song.getMap));
    await _audioPlayer.setUrl(song.uri ?? "");
    _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, songsProvider, child) {
        return Scaffold(
          backgroundColor: GlobalVariables.backgroundColor,
          appBar: AppBar(
            backgroundColor: GlobalVariables.appBarColor,
            toolbarHeight: kToolbarHeight - 10,
            elevation: 38,
            shadowColor: Colors.black12,
            leading: IconButton(onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white70)),
            centerTitle: true,
            title: Text("Now Playing", style: GoogleFonts.manrope(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
            actions: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CircleAvatar(
                    radius: 16,
                    child: Image.network(
                      "https://qph.cf2.quoracdn.net/main-qimg-7a677dd3e89f2ac85ac5fd0d9993d77b-lq",
                      fit: BoxFit.fill,)
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.45,
                  child: Center(
                    child: CircleAvatar(
                      radius: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: QueryArtworkWidget(
                          controller: widget.audioQuery,
                          artworkHeight: MediaQuery
                              .of(context)
                              .size
                              .height * 0.4,
                          artworkWidth: MediaQuery
                              .of(context)
                              .size
                              .width * 0.6,
                          artworkFit: BoxFit.cover,
                          id: widget.songList[widget.index].id,
                          type: ArtworkType.AUDIO,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(top: 1),
                  alignment: Alignment.center,
                  child: ListTile(
                      subtitle: Text(widget.songList[widget.index].artist ??
                          widget.songList[widget.index].composer ?? "unknown",
                        style: GoogleFonts.manrope(color: Colors.white24,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,),
                      title: Text(widget.songList[widget.index].title,
                        style: GoogleFonts.openSans(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),),
                      trailing: GestureDetector(
                        onTap: () async {
                          DataBaseHelper dbhelper=DataBaseHelper();
                         dbhelper.addFavourites(Favourites(widget.songList[widget.index].getMap));
                        },
                        child: const Icon(
                          Icons.favorite_outlined, color: Colors.white, size: 26,),
                      )
                  ),
                ),
                Slider(
                  value: sliderValue,
                  allowedInteraction: SliderInteraction.tapAndSlide,
                  label: "$position",
                  onChanged: (value) {
                    sliderValue = value;
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                     position = sliderValue * _audioPlayer.duration!.inSeconds;
                    _audioPlayer.seek(Duration(seconds: position.round()));
                  },
                  min: 0.0,
                  max: 1.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: () {},
                        icon: const Icon(CupertinoIcons.shuffle,
                          color: CupertinoColors.activeBlue, size: 30,)),
                    IconButton(onPressed: () {
                      if (widget.index > 0) {
                        songsProvider.updateCurrentSong(
                            widget.songList[widget.index - 1]);
                        _audioPlayer.dispose();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) =>
                                PlaySong(audioQuery: widget.audioQuery,
                                    songList: widget.songList,
                                    index: widget.index - 1),));
                      }
                    },
                        icon: const Icon(CupertinoIcons.backward_end,
                          color: CupertinoColors.white, size: 30,)),
                    isPlaying ? IconButton(onPressed: () {
                      isPlaying = !isPlaying;
                      setState(() {});
                      _audioPlayer.pause();
                    },
                      icon: const Icon(
                        CupertinoIcons.pause, color: CupertinoColors.systemCyan,
                        size: 35,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 6,
                          ),
                          Shadow(
                            color: Colors.white,
                            blurRadius: 6,

                          ),
                          Shadow(
                            color: Colors.white,
                            blurRadius: 6,

                          ),
                        ],),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(25),
                        // Set the elevation as needed
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.cyan.shade200),
                        // Set the button color
                      ),) :
                    IconButton(onPressed: () {
                      isPlaying = !isPlaying;
                      setState(() {});
                      _audioPlayer.seek(_audioPlayer.position);
                      _audioPlayer.play();
                    },
                      icon: const Icon(
                        CupertinoIcons.play, color: CupertinoColors.systemCyan,
                        size: 35,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 6,
                          ),
                          Shadow(
                            color: Colors.white,
                            blurRadius: 6,

                          ),
                          Shadow(
                            color: Colors.white,
                            blurRadius: 6,

                          ),
                        ],),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(25),
                        // Set the elevation as needed
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.cyan.shade200),
                        // Set the button color
                      ),),
                    IconButton(onPressed: () {
                      print(
                          "Before updateCurrentSong: ${songsProvider.currentSong.displayName}");
                      songsProvider.updateCurrentSong(
                          widget.songList[widget.index + 1]);
                      print(
                          "After updateCurrentSong: ${songsProvider.currentSong.displayName}");
                      _audioPlayer.dispose();
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PlaySong(audioQuery: widget.audioQuery, songList: widget.songList, index: widget.index+1),));
                      // songsProvider.updateCurrentSong(widget.songList[widget.index+1]);
                      print("clicked");
                    },
                        icon: const Icon(CupertinoIcons.forward_end,
                          color: CupertinoColors.white, size: 30,)),
                    IconButton(onPressed: () {},
                        icon: const Icon(CupertinoIcons.repeat,
                          color: CupertinoColors.activeBlue, size: 30,)),
                  ],
                ),
                const SizedBox(height: 10,),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text("Lyrics", style: GoogleFonts.manrope(
                            color: Colors.white24,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                        IconButton(onPressed: () {
                          setState(() {
                            isLyricsOpened = !isLyricsOpened;
                          });
                        },
                            icon: Icon(isLyricsOpened
                                ? CupertinoIcons.chevron_compact_down
                                : CupertinoIcons.chevron_compact_up,
                              color: Colors.white,
                              size: 40,)),
                      ],
                    )),
                isLyricsOpened ? AnimatedContainer(
                    duration: const Duration(seconds: 4),
                    // Adjust the duration as needed
                    curve: Curves.easeInExpo,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 25,),
                    padding: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                        color: GlobalVariables.appBarColor,
                        border: null,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)
                        )
                    ),
                    constraints: const BoxConstraints(
                        minHeight: 400,
                        maxHeight: 500
                    ),
                    child: ListView.builder(
                      itemCount: lyrics.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) =>
                          Center(child: index % 2 == 0 ? ShaderMask(
                              shaderCallback: (bounds) {
                                return GlobalVariables.getLineGradient()
                                    .createShader(bounds);
                              },
                              child: Text(
                                lyrics[index],
                                style: GoogleFonts.manrope(
                                    color: Colors.white,
                                    fontSize: 17.5,
                                    fontWeight: FontWeight
                                        .w500),
                              )) : Text(lyrics[index],
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16))),)
                ) : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }
}
